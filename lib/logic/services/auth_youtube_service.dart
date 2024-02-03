import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/rating_state.dart';
import 'package:youtube_clone/data/models/subscription_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/env/env.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/dio.dart';
import 'package:youtube_clone/logic/services/either_extension.dart';

class AuthYoutubeService {
  final Dio _dio;

  static const authority = 'www.googleapis.com';
  static const videosEnd = '/youtube/v3/videos';
  static const rateEnd = '/youtube/v3/videos/rate/';
  static const getRatingEnd = '/youtube/v3/videos/getRating';
  static const subscriptionsEnd = '/youtube/v3/subscriptions';
  static const maxResults = '20';
  static final key = Env.apiKey;

  const AuthYoutubeService(this._dio);

  Future<Either<YoutubeFailure, BaseInfo<Video>>> getLikedVideos({
    String? pageToken,
  }) async {
    try {
      final queryParameters = {
        'part': 'snippet,statistics,contentDetails',
        'maxResults': maxResults,
        'myRating': 'like',
        'pageToken': pageToken,
        'key': key,
      };
      final url = Uri.https(
        authority,
        videosEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);
      final videos =
          (response.data['items'] as List).map((video) => Video.fromJson(video)).toList();

      final nextPageToken = response.data['nextPageToken'];
      final totalResults = response.data['pageInfo']['totalResults'];
      final resultsPerPage = response.data['pageInfo']['resultsPerPage'];
      final nextPageAvailable = nextPageToken != null && nextPageToken.isNotEmpty;
      final wholePages = totalResults ~/ resultsPerPage;
      final totalPages = totalResults % resultsPerPage != 0 ? (wholePages + 1) : (wholePages);

      return right(
        BaseInfo<Video>(
          data: videos,
          nextPageToken: nextPageToken,
          nextPageAvailable: nextPageAvailable,
          totalPages: totalPages,
          itemsPerPage: totalResults,
        ),
      );
    } on DioException catch (e, st) {
      log('dio caught exception inside getLikedVideos()', error: e, stackTrace: st);

      final failure = FailureData(
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      );

      if (e.isNoConnectionError) {
        return left(
          const NoConnectionFailure(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // these are shorts from liked videos
  Future<Either<YoutubeFailure, BaseInfo<Video>>> getLikedShorts({
    String? nextPageToken,
  }) async {
    try {
      final videosOrFailure = await getLikedVideos(pageToken: nextPageToken);
      final videosInfo = videosOrFailure.rightOrDefault!;
      final videos = videosInfo.data;

      final ids = videos.map((video) => video.id).toList().join(',');

      final queryParameters = {
        'part': 'short',
        'id': ids,
      };
      final uri = Uri.https(
        'yt.lemnoslife.com',
        'videos',
        queryParameters,
      );

      // TODO add interceptors here to handle offline cases
      final Dio dio = Dio();
      final response = await dio.getUri(uri);

      if (response.data['items'] == null) {
        return right(
          // disabled may also indicate a problem in the unoff api
          const BaseInfo(disabled: true),
        );
      }

      final items = response.data['items'] as List<dynamic>;
      final newShortsList = <Video>[];

      for (final item in items) {
        // if it is a short, then i should add the video to the
        // shorts list - a list of normal videos from get
        // liked videos func
        if (item['short']['available'] == true) {
          newShortsList.add(
            videos.firstWhere((element) => element.id == item['id']),
          );
        }
      }

      return right(
        BaseInfo<Video>(
          data: newShortsList,
          nextPageToken: videosInfo.nextPageToken,
          nextPageAvailable: videosInfo.nextPageAvailable,
          totalPages: videosInfo.totalPages,
          itemsPerPage: videosInfo.itemsPerPage,
        ),
      );
    } on DioException catch (e, st) {
      log('dio caught exception inside getLikedShorts()', error: e, stackTrace: st);

      final failure = FailureData(
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      );

      if (e.isNoConnectionError) {
        return left(
          const NoConnectionFailure(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // *********************

  Future<RatingState> getVideoRating({
    required String videoId,
    required AuthState authState,
  }) async {
    try {
      late final RatingState ratingState;

      // TODO change this to if/else
      authState.maybeWhen(
        orElse: () => ratingState = const Neither(),
        authenticated: () async {
          final queryParams = {
            'id': videoId,
            'key': key,
          };
          final url = Uri.https(
            authority,
            getRatingEnd,
            queryParams,
          );

          final response = await _dio.getUri(url);
          final rating = response.data['items'][0]['rating'] as String;

          if (rating == 'like') {
            ratingState = const Liked();
          } else if (rating == 'none') {
            ratingState = const Neither();
          } else {
            ratingState = const Disliked();
          }
        },
      );

      return ratingState;
    } on DioException catch (e, st) {
      log(
        'dio caught exception inside getVideoRating($videoId, $authState)',
        error: e,
        stackTrace: st,
      );

      final failure = FailureData(
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      );

      if (e.isNoConnectionError) {
        throw const NoConnectionFailure();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  Uri _makeUrl({
    required String videoId,
    required RatingState rating,
    // whether to like the video or not
    bool like = false,
  }) {
    late final Map<String, String> queryParams;
    late final Uri url;

    // if (rating == const Liked() || rating == const Disliked()) {
    if (rating case const Liked() || const Disliked()) {
      queryParams = {
        'id': videoId,
        'rating': 'none',
      };
    } else if (like) {
      queryParams = {
        'id': videoId,
        'rating': 'like',
      };
    } else if (!like) {
      queryParams = {
        'id': videoId,
        'rating': 'dislike',
      };
    }

    url = Uri.https(
      authority,
      rateEnd,
      queryParams,
    );

    return url;
  }

  Future<RatingState> likeVideo({
    required String videoId,
    required AuthState authState,
  }) async {
    late final RatingState ratingState;
    final rating = await getVideoRating(videoId: videoId, authState: authState);

    // TODO change this to if/else
    rating.maybeWhen(
      orElse: () async {
        await _dio.postUri(
          _makeUrl(videoId: videoId, rating: rating, like: true),
        );
        ratingState = const Liked();
      },
      liked: () async {
        await _dio.postUri(
          _makeUrl(videoId: videoId, rating: rating),
        );
        ratingState = const Neither();
      },
    );

    return ratingState;
  }

  Future<RatingState> dislikeVideo({
    required String videoId,
    required AuthState authState,
  }) async {
    late final RatingState ratingState;
    final rating = await getVideoRating(videoId: videoId, authState: authState);

    // TODO change this to if/else
    rating.maybeWhen(
      orElse: () async {
        await _dio.postUri(
          _makeUrl(videoId: videoId, rating: rating),
        );
        ratingState = const Disliked();
      },
      disliked: () async {
        await _dio.postUri(
          _makeUrl(videoId: videoId, rating: rating),
        );
        ratingState = const Neither();
      },
    );

    return ratingState;
  }

  // *******************

  // this is a list of subscriptions - channels that
  // the user is subscribed to
  Future<List<Subscription>> getSubscriptions({
    String? channelId,
    String? pageToken,
  }) async {
    final queryParams = {
      'part': 'id,snippet,contentDetails,subscriberSnippet',
      'mine': 'true',
      'pageToken': pageToken,
      'maxResults': '50',
      'key': key,
    };
    final url = Uri.https(
      authority,
      subscriptionsEnd,
      queryParams,
    );

    final response = await _dio.getUri(url);
    final subscriptions = List.from(response.data['items'])
        .map(
          (map) => Subscription.fromJson(map),
        )
        .toList();
    final nextPageToken = response.data['nextPageToken'];

    if (nextPageToken != null) {
      final rest = await getSubscriptions(
        channelId: channelId,
        pageToken: nextPageToken,
      );

      subscriptions.addAll(rest);
    }

    return subscriptions;
  }

  // removed optional (nullable) pageToken
  // check if the user is subscribed to a given channel or not -
  // from a video or a short, which contain the CHANNEL's id
  Future<bool> subscribed({
    required String channelId,
    required AuthState authState,
  }) async {
    late final bool containsId;

    // TODO change this to if/else
    authState.maybeWhen(
      orElse: () => containsId = false,
      authenticated: () async {
        final subscriptions = await getSubscriptions(channelId: channelId);

        containsId = subscriptions.any(
          (subscription) => subscription.snippet.theChannelId == channelId,
        );

        // if the channel contains the same channel id as the list of subs, then
        // the user is subbed to the channel, otherwise - he's not
        // return containsChannelId;
      },
    );

    return containsId;
  }

  Future<bool> changeSubscription({
    required String channelId,
    // required bool subbedState,
    required AuthState authState,
  }) async {
    final alreadySubscribed = await subscribed(
      channelId: channelId,
      authState: authState,
    );

    return alreadySubscribed
        ? unsubscribe(channelId: channelId, authState: authState)
        : subscribe(channelId: channelId, authState: authState);
  }

  Future<bool> subscribe({
    required String channelId,
    required AuthState authState,
  }) async {
    // if the user is already subbed, return true
    if (await subscribed(channelId: channelId, authState: authState)) {
      return true;
    }

    final queryParams = {
      'part': 'id,snippet,contentDetails,subscriberSnippet',
    };
    final requestBody = {
      'snippet': {
        'resourceId': {'channelId': channelId}
      }
    };
    final url = Uri.https(
      authority,
      subscriptionsEnd,
      queryParams,
    );
    final response = await _dio.postUri(
      url,
      data: requestBody,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // failure happened and the user couldn't sub to the channel
      return false;
    }
  }

  Future<bool> unsubscribe({
    required String channelId,
    required AuthState authState,
  }) async {
    if (!(await subscribed(channelId: channelId, authState: authState))) {
      return false;
    }

    final subscriptions = await getSubscriptions(channelId: channelId);
    final subId = subscriptions
        .firstWhere((subscription) => subscription.snippet.theChannelId == channelId)
        .subscriptionId;
    final queryParams = {'id': subId};
    final url = Uri.https(
      authority,
      subscriptionsEnd,
      queryParams,
    );
    final response = await _dio.deleteUri(url);

    if (response.statusCode == 204) {
      return false;
    } else {
      return true;
    }
  }

  // if user is subscribed, he'll unsubscribe and vice versa
  // TODO finish this and use it
  // Future<bool> changeSubscription(String channelId) async {
  //   final channels = await _getChannelSubscriptions(channelId);

  //   final subscriptionId = channels.firstWhere(
  //     (channel) => channel.snippet.theChannelId == channelId,
  //     orElse: () {
  //       log('failure, there`s no channel with this id');
  //       return channels.first;
  //     },
  //   ).subscriptionId;

  //   if (subscriptionId.isEmpty) {
  //     // channels.add(value);
  //   }

  //   final requestBody = {
  //     'snippet': {
  //       'resourceId': {
  //         'channelId': channelId,
  //       },
  //     },
  //   };

  //   Uri makeUrl(bool subscribed) {
  //     late final Map<String, String> queryParams;
  //     late final Uri url;

  //     // if the user is subscribed, he'll unsubscribe from
  //     // the clicked channel
  //     if (subscribed) {
  //       queryParams = {'id': subscriptionId};

  //       url = Uri.https(
  //         authority,
  //         subscriptionsEnd,
  //         queryParams,
  //       );

  //       return url;
  //       // otherwise, he'll subscribe
  //     } else {
  //       queryParams = {
  //         'part': 'id,snippet,contentDetails,subscriberSnippet',
  //       };

  //       url = Uri.https(
  //         authority,
  //         subscriptionsEnd,
  //         queryParams,
  //       );

  //       return url;
  //     }
  //   }

  //   final sub = await subscribed(channelId);

  //   if (sub) {
  //     await _dio.deleteUri(makeUrl(sub));
  //     return false;
  //   } else {
  //     await _dio.postUri(
  //       makeUrl(sub),
  //       data: requestBody,
  //     );
  //     return true;
  //   }
  // }
}
