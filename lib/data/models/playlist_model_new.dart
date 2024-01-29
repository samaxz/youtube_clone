// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'playlist_model_new.g.dart';

class Playlist {
  final String? id;
  final String? thumbnail;
  final String? title;
  final int? videoCount;
  final Author? author;
  final String? publishedTimeText;

  const Playlist({
    this.id,
    this.thumbnail,
    this.title,
    this.videoCount,
    this.author,
    this.publishedTimeText,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      thumbnail: json['thumbnailVideo']?['thumbnails']?[0]?['url'],
      title: json['title'],
      videoCount: json['videoCount'],
      author: Author.fromJson(json['authors']?[0]),
      publishedTimeText: json['publishedTimeText'],
    );
  }

  @override
  String toString() {
    return 'Playlist(id: $id, thumbnail: $thumbnail, title: $title, videoCount: $videoCount, author: $author, publishedTimeText: $publishedTimeText)';
  }
}

@JsonSerializable()
class Author {
  final String? channelName;
  final String? channelHandle;
  final String? channelId;
  final String? channelApproval;

  const Author({
    this.channelName,
    this.channelHandle,
    this.channelId,
    this.channelApproval,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
