import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/models/channel/channel_about_model.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/data/models/channel/channel_subscription_new.dart';
import 'package:youtube_demo/data/models/comment_model.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/data/models/channel/community_post_model.dart';
import 'package:youtube_demo/data/models/playlist/playlist_item_model.dart';
import 'package:youtube_demo/data/models/playlist/playlist_model.dart';
import 'package:youtube_demo/data/models/playlist_model_new.dart'
    as playlist_new;
import 'package:youtube_demo/data/models/video/video_category_model.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/env/env.dart';
import 'package:youtube_demo/services/common/dio.dart';
import 'package:youtube_demo/services/common/either_extension.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/notifiers/searched_items_notifier.dart';

class YoutubeService {
  final Dio _dio;

  static const authority = 'www.googleapis.com';
  static const searchEnd = '/youtube/v3/search';
  static const videosEnd = '/youtube/v3/videos';
  static const videoCategoriesEnd = '/youtube/v3/videoCategories';
  static const commentsEnd = '/youtube/v3/commentThreads';
  static const channelsEnd = '/youtube/v3/channels';
  static const playlistsEnd = '/youtube/v3/playlists';
  static const playlistItemsEnd = '/youtube/v3/playlistItems';
  static const maxResults = '20';
  static final key = Env.apiKey;

  const YoutubeService(this._dio);

  // * this is for searching items
  Future<Either<YoutubeFailure, BaseInfo<Item>>> searchItems(
    String query, {
    String? pageToken,
    String regionCode = 'RU',
  }) async {
    try {
      final queryParameters = {
        'part': 'snippet',
        'maxResults': maxResults,
        'q': query,
        'regionCode': regionCode,
        'type': 'video,channel,playlist',
        'pageToken': pageToken,
        'key': key,
      };

      final url = Uri.https(
        authority,
        searchEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final items = List.from(response.data['items']);

      List<Item> searchItems = [];

      List<String> videoIds = [];
      List<String> playlistIds = [];
      List<String> channelIds = [];

      for (final element in items) {
        if (element['id']['kind'] == 'youtube#video') {
          // final video = await _getVideoDetails(element['id']['videoId']);
          // searchItems.add(video);
          videoIds.add(element['id']['videoId']);
        } else if (element['id']['kind'] == 'youtube#playlist') {
          playlistIds.add(element['id']['playlistId']);
        } else {
          channelIds.add(element['id']['channelId']);
        }
      }

      final videos = await _getVideoDetails(videoIds.join(','));
      final playlists = await _getPlaylistDetails(playlistIds.join(','));
      final channels = await _getChannelDetails(channelIds.join(','));

      searchItems
        ..addAll(videos)
        ..addAll(playlists)
        ..addAll(channels);

      final nextPageToken = response.data['nextPageToken'];
      final totalResults = response.data['pageInfo']['totalResults'];
      final resultsPerPage = response.data['pageInfo']['resultsPerPage'];

      final wholePages = totalResults ~/ resultsPerPage;
      final totalPages =
          totalResults % resultsPerPage != 0 ? (wholePages + 1) : (wholePages);

      return right(
        BaseInfo(
          data: searchItems,
          nextPageToken: nextPageToken,
          // * not sure this is the right one
          totalPages: totalPages,
          itemsPerPage: resultsPerPage,
        ),
      );
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // * these are used for search to get details about videos,
  // playlists and channels

  // * this is for searched videos details (videos and their details)
  Future<List<Video>> _getVideoDetails(String videoId) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,statistics,contentDetails',
        'id': videoId,
        'key': key,
      };

      final url = Uri.https(
        authority,
        videosEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final videosResponse = (response.data['items'] as List)
          .map((video) => Video.fromJson(video))
          .toList();

      return videosResponse;
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      // * i should prolly rethrow these, but, whatever
      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  // * this is for searched playlists' details
  Future<List<Playlist>> _getPlaylistDetails(String playlistId) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,status',
        'id': playlistId,
        'key': key,
      };

      final url = Uri.https(
        authority,
        playlistsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final playlistResponse = (response.data['items'] as List)
          .map((playlist) => Playlist.fromJson(playlist))
          .toList();

      return playlistResponse;
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  // * this is sor searched channels' details
  Future<List<Channel>> _getChannelDetails(String channelId) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,statistics',
        'id': channelId,
        'key': key,
      };

      final url = Uri.https(
        authority,
        channelsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final channelResponse = (response.data['items'] as List)
          .map((channel) => Channel.fromJson(channel))
          .toList();

      return channelResponse;
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  // * this is used for both normal videos and shorts
  Future<Either<YoutubeFailure, BaseInfo<Video>>> getPopularVideos({
    String? pageToken,
    String maxResults = maxResults,
    String regionCode = 'RU',
    String videoCategoryId = '0',
  }) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,statistics,status',
        'chart': 'mostPopular',
        'maxResults': maxResults,
        'regionCode': regionCode,
        // TODO make the user be able to select this
        'videoCategoryId': videoCategoryId,
        'pageToken': pageToken,
        'key': key,
      };

      final url = Uri.https(
        authority,
        videosEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final videos = (response.data['items'] as List)
          .map((video) => Video.fromJson(video))
          .toList();

      final nextPageToken = response.data['nextPageToken'];
      final totalResults = response.data['pageInfo']['totalResults'];
      final resultsPerPage = response.data['pageInfo']['resultsPerPage'];
      final nextPageAvailable =
          nextPageToken != null && nextPageToken.isNotEmpty;

      final wholePages = totalResults ~/ resultsPerPage;
      final totalPages =
          totalResults % resultsPerPage != 0 ? (wholePages + 1) : (wholePages);

      return right(
        BaseInfo<Video>(
          data: videos,
          nextPageToken: nextPageToken,
          nextPageAvailable: nextPageAvailable,
          totalPages: totalPages,
          itemsPerPage: totalResults,
        ),
      );
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // * get video categories from popular videos, based on the
  // region code
  Future<List<VideoCategory>> getVideoCategories() async {
    final queryParameters = {
      'part': 'snippet',
      // TODO make this selectable by user
      'regionCode': 'RU',
      'key': key,
    };

    final url = Uri.https(
      authority,
      videoCategoriesEnd,
      queryParameters,
    );

    final response = await _dio.getUri(url);

    if (response.statusCode == 200) {
      final categories = (response.data['items'] as List)
          .map((category) => VideoCategory.fromJson(category))
          .toList();

      return categories;
    }

    return [];
  }

  // * this is for shorts
  // * this method uses unofficial api under the hood

  Future<Either<YoutubeFailure, BaseInfo<Video>>> getPopularShorts({
    String? pageToken,
  }) async {
    try {
      final popularVideosOrFailure = await getPopularVideos(
        pageToken: pageToken,
      );
      final popularVideosBaseInfo = popularVideosOrFailure.rightOrDefault!;
      final popularVideos = popularVideosOrFailure.rightOrDefault!.data;

      List<Video> shorts = [];

      _getShortsFromVideos(
        videos: popularVideos,
        nextPageToken: pageToken,
      ).then(
        (value) => shorts.addAll(value.rightOrDefault!.videos),
      );

      return right(popularVideosBaseInfo);
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // * this is a separate method just for getting uploads from
  // a channel
  Future<Uploads> getChannelUploads(String channelId) async {
    // final uploadsId = '$channelId'[1] = 'U';
    // final characters = channelId.characters.toList();
    // characters[1] = 'U';
    // final uploadsId = characters.join();

    final videosId = channelId.replaceRange(0, 2, 'UULF');
    final videos = await getPlaylistVideos(videosId);

    final shortsId = channelId.replaceRange(0, 2, 'UUSH');
    final shorts = await getPlaylistVideos(shortsId);

    return Uploads(
      videos: videos,
      shorts: shorts,
    );
  }

  Future<List<Video>> getPlaylistVideos(
    String playlistId, {
    String? maxResults = '7',
  }) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,status',
        'playlistId': playlistId,
        'maxResults': maxResults,
        'key': key,
      };

      final url = Uri.https(
        authority,
        playlistItemsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      // * this is the playlist
      final playlistItemsRaw = response.data['items'] as List;

      final playlistItems = playlistItemsRaw
          .map((playlistItemRaw) => PlaylistItem.fromJson(playlistItemRaw))
          .toList();

      List<String> playlistVideosIds = [];

      for (final element in playlistItems) {
        playlistVideosIds.add(element.contentDetails.videoId!);
      }

      final playlistVideosOrFailure = await _getListOfVideoDetails(
        playlistVideosIds,
      );

      final playlistVideos = playlistVideosOrFailure.rightOrDefault!;

      return playlistVideos;
    } on DioException catch (e, st) {
      log(
        'dio caught an exception in service - _getPlaylistVideos($playlistId)',
        error: e,
        stackTrace: st,
      );

      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else if (e.response?.statusCode == 404) {
        // * this is a very retarded solution, but i'll take it for now
        return [];
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  // * this returns a list of videos with their details

  // * this one is exclusively for the inner use - it's used for
  // converting uploads ids to videos and converting playlist items
  // to videos
  Future<Either<YoutubeFailure, List<Video>>> _getListOfVideoDetails(
    List<String> videoIds,
  ) async {
    try {
      final queryParameters = {
        'part': 'snippet,statistics,contentDetails',
        'id': videoIds,
        'key': key,
      };

      final url = Uri.https(
        authority,
        videosEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final videosResponse = (response.data['items'] as List)
          .map((video) => Video.fromJson(video))
          .toList();

      return right(videosResponse);
    } on DioException catch (e, st) {
      log(
        'error happened inside service - _getListOfVideoDetails():',
        error: e,
        stackTrace: st,
      );

      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
        stackTrace: st,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  Future<Either<YoutubeFailure, BaseInfo<Comment>>> getVideoComments(
    String videoId, {
    String? pageToken,
  }) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,replies',
        'videoId': videoId,
        'maxResults': maxResults,
        // TODO add time here and implement feature where
        // user decides what he wants to see
        'order': 'relevance',
        // * this doesn't work with both the official api and unofficial apis
        'pageToken': pageToken,
        'textFormat': 'plainText',
        'key': key,
      };

      final url = Uri.https(
        authority,
        commentsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      if (response.statusCode == 403) {
        return right(
          const BaseInfo<Comment>(
            disabled: true,
          ),
        );
      }

      final comments = (response.data['items'] as List)
          .map((item) => Comment.fromJson(item))
          .toList();

      final nextPageToken = response.data['nextPageToken'];
      final totalResults = response.data['pageInfo']['totalResults'];
      final resultsPerPage = response.data['pageInfo']['resultsPerPage'];
      final nextPageAvailable =
          nextPageToken != null && nextPageToken.isNotEmpty;

      final wholePages = totalResults ~/ resultsPerPage;
      final totalPages =
          totalResults % resultsPerPage != 0 ? (wholePages + 1) : (wholePages);

      return right(
        BaseInfo<Comment>(
          data: comments,
          nextPageToken: nextPageToken,
          nextPageAvailable: nextPageAvailable,
          totalPages: totalPages,
          itemsPerPage: totalResults,
        ),
      );
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else if (e.response?.statusCode == 403) {
        return right(
          const BaseInfo<Comment>(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // * small info about the channel: title and subscriptions count

  Future<Either<YoutubeFailure, Channel>> getChannelInfoEither(
    String channelId,
  ) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,statistics',
        'id': channelId,
        'key': key,
      };

      final url = Uri.https(
        authority,
        channelsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final channelRaw = response.data['items'] as List;

      final channel = Channel.fromJson(channelRaw.first);

      return right(channel);
    } on DioException catch (e, st) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
        stackTrace: st,
      );

      log(
        'dio exception has been thrown inside service - getChannelInfo():',
        error: e,
        stackTrace: st,
      );

      if (e.isNoConnectionError) {
        return left(const YoutubeFailure.noConnection());
      } else {
        return left(YoutubeFailure(failure));
      }
    }
  }

  Future<Channel> getChannelInfo(String channelId) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,statistics',
        'id': channelId,
        'key': key,
      };

      final url = Uri.https(
        authority,
        channelsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final channelRaw = response.data['items'] as List;

      final channel = Channel.fromJson(channelRaw.first);

      return channel;
    } on DioException catch (e, st) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
        stackTrace: st,
      );

      log(
        'dio exception has been thrown inside service - getChannelInfo():',
        error: e,
        stackTrace: st,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  // ***** these are outdated and i don't use them anymore
  Future<String?> _getUploadsPlaylistIdFromChannelId(String channelId) async {
    final channel = await getChannelInfoEither(channelId);
    final uploads = channel.rightOrDefault?.contentDetails?.uploads;

    return uploads;
  }

  Future<Either<YoutubeFailure, List<String>>> getChannelUploadsIds(
    String channelId, {
    String? pageToken,
  }) async {
    try {
      final uploadsId = await _getUploadsPlaylistIdFromChannelId(channelId);

      final queryParams = {
        'part': 'id,snippet,contentDetails,status',
        'playlistId': uploadsId,
        'maxResults': maxResults,
        'nextPageToken': pageToken,
        'key': key,
      };

      final url = Uri.https(
        authority,
        playlistItemsEnd,
        queryParams,
      );

      final response = await _dio.getUri(url);
      final playlistItemsRaw = response.data['items'] as List;

      final playlistItems = playlistItemsRaw
          .map((playlistItemRaw) => PlaylistItem.fromJson(playlistItemRaw))
          .toList();

      final List<String> uploadsIdList = [];

      final uploadsVideoId = playlistItems
          .where((video) => video.contentDetails.videoId != null)
          .toList();

      for (int i = 0; i < uploadsVideoId.length; i++) {
        uploadsIdList.add(uploadsVideoId[i].contentDetails.videoId!);
      }

      return right(uploadsIdList);
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  Future<Either<YoutubeFailure, Uploads>> convertUploadsIdsToVideos(
    String channelId,
  ) async {
    try {
      final uploadsIds = await getChannelUploadsIds(channelId);
      final uploadsVideoId = uploadsIds.rightOrDefault!;

      final uploadsOrFailure = await _getListOfVideoDetails(uploadsVideoId);
      final uploads = uploadsOrFailure.rightOrDefault!;

      final videoTypesOrFailure = await _getShortsFromVideos(videos: uploads);
      final videoTypes = videoTypesOrFailure.rightOrDefault;

      final videosNew = videoTypes!.videos;
      final shortsNew = videoTypes.shorts;

      return right(
        Uploads(
          videos: videosNew,
          shorts: shortsNew,
        ),
      );
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }
  // ************************

  Future<Either<YoutubeFailure, List<String>>> _getPlaylistsItemsVideoIds(
    String playlistId,
  ) async {
    try {
      final queryParameters = {
        'part': 'id,snippet,contentDetails,status',
        'playlistId': playlistId,
        'maxResults': maxResults,
        'key': key,
      };

      final url = Uri.https(
        authority,
        playlistItemsEnd,
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final playlistItemsRaw = response.data['items'] as List;

      final playlistItems = playlistItemsRaw
          .map((playlistItemRaw) => PlaylistItem.fromJson(playlistItemRaw))
          .toList();

      final playlistItemsNew = playlistItems
          .where((element) => element.contentDetails.videoId != null);

      List<String> playlistItemsVideoIds = [];

      for (final element in playlistItemsNew) {
        playlistItemsVideoIds.add(element.contentDetails.videoId!);
      }

      return right(playlistItemsVideoIds);
    } on DioException catch (e, st) {
      log(
        'dio exception has been thrown in service - _getPlaylistsItemsVideoIds()',
        error: e,
        stackTrace: st,
      );

      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  // ****** this is outdated
  // * i can get playlist items videos ids and then convert them into videos -
  // i don't have to get the entire playlist items for it
  Future<Either<YoutubeFailure, List<Video>>> convertPlaylistItemsToVideos(
    String playlistId,
  ) async {
    try {
      final playlistItemsOrFailure =
          await _getPlaylistsItemsVideoIds(playlistId);
      final playlistItemsVideoIds = playlistItemsOrFailure.rightOrDefault!;

      final videosOrFailure =
          await _getListOfVideoDetails(playlistItemsVideoIds);
      final videosNew = videosOrFailure.rightOrDefault!;

      return right(videosNew);
    } on DioException catch (e, st) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
        stackTrace: st,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }
  // ********************

  // ********************************************
  // ******** this is the unofficial api ********
  // ********************************************

  // * this'll simply be a list of videos (that are shorts)
  Future<Either<YoutubeFailure, VideoTypes>> _getShortsFromVideos({
    List<Video>? videos,
    String? nextPageToken,
  }) async {
    try {
      final ids = videos?.map((video) => video.id).toList().join(',');

      final queryParameters = {
        'part': 'short',
        'id': ids,
        'pageToken': nextPageToken,
      };

      final url = Uri.https(
        'yt.lemnoslife.com',
        'videos',
        queryParameters,
      );

      final response = await _dio.getUri(url);
      // * for some reason, casting "as" doesn't work correctly
      final items = List<Map<String, dynamic>>.from(response.data['items']);

      List<Video> newShortsList = [];
      List<Video> newVideosList = [];

      for (Map<String, dynamic> item in items) {
        if (item['short']['available'] == true) {
          newShortsList.add(
            videos!.firstWhere((element) => element.id == item['id']),
          );
        } else {
          newVideosList.add(
            videos!.firstWhere((element) => element.id == item['id']),
          );
        }
      }

      return right(
        VideoTypes(
          videos: newVideosList,
          shorts: newShortsList,
        ),
      );
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        return left(
          const YoutubeFailure.noConnection(),
        );
      } else {
        return left(
          YoutubeFailure(failure),
        );
      }
    }
  }

  Future<List<playlist_new.Playlist>> getChannelPlaylists(
    String channelId,
  ) async {
    try {
      final queryParameters = {
        'part': 'playlists',
        'id': channelId,
      };

      final url = Uri.https(
        'yt.lemnoslife.com',
        'channels',
        queryParameters,
      );

      final response = await _dio.getUri(url);
      final playlistsRaw = List<Map<String, dynamic>>.from(
        response.data['items']?[0]?['playlistSections']?[0]?['playlists'],
      );
      final playlists = playlistsRaw
          .map((rawPlaylist) => playlist_new.Playlist.fromJson(rawPlaylist))
          .toList();

      return playlists;
    } on DioException catch (e, st) {
      log(
        'dio exception has been thrown inside service - getChannelPlaylists()',
        error: e,
        stackTrace: st,
      );

      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
        stackTrace: st,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  Future<List<CommunityPost>> getChannelCommunityPosts(String channelId) async {
    try {
      final queryParameters = {
        'part': 'community',
        'id': channelId,
      };

      final url = Uri.https(
        'yt.lemnoslife.com',
        'channels',
        queryParameters,
      );

      final response = await _dio.getUri(url);
      final communityPostsRaw = List<Map<String, dynamic>>.from(
        response.data['items']?[0]?['community'],
      );

      final communityPosts = communityPostsRaw
          .map((rawPost) => CommunityPost.fromJson(rawPost))
          .toList();

      return communityPosts;
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  Future<List<ChannelSubscription>> getChannelSubscriptions(
    String channelId,
  ) async {
    try {
      final queryParameters = {
        'part': 'channels',
        'id': channelId,
      };

      final url = Uri.https(
        'yt.lemnoslife.com',
        'channels',
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final channelSubsRaw = List<Map<String, dynamic>>.from(
        response.data['items']?[0]?['channelSections'][0]['sectionChannels'],
      );

      if (channelSubsRaw.isEmpty) return [];

      final channelSubs = channelSubsRaw
          .map((rawSub) => ChannelSubscription.fromJson(rawSub))
          .toList();

      return channelSubs;
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else if (e.response?.statusCode == 404) {
        return [];
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }

  Future<About> getChannelAbout(String channelId) async {
    try {
      final queryParameters = {
        'part': 'about',
        'id': channelId,
      };

      final url = Uri.https(
        'yt.lemnoslife.com',
        'channels',
        queryParameters,
      );

      final response = await _dio.getUri(url);

      final aboutRaw = Map<String, dynamic>.from(
        response.data['items']?[0]?['about'],
      );

      final about = About.fromJson(aboutRaw);

      return about;
    } on DioException catch (e) {
      final failure = FailureData(
        e.response?.statusMessage,
        e.response?.statusCode,
      );

      if (e.isNoConnectionError) {
        throw const YoutubeFailure.noConnection();
      } else {
        throw YoutubeFailure(failure);
      }
    }
  }
}
