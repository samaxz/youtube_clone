import 'package:json_annotation/json_annotation.dart';

part 'channel_about_model.g.dart';

@JsonSerializable()
class About {
  final Stats? stats;
  final String? description;
  final String? title;
  final String? location;
  final List<Link?> links;
  final String? handle;

  const About({
    this.stats,
    this.description,
    this.title,
    this.location,
    required this.links,
    this.handle,
  });

  factory About.fromJson(Map<String, dynamic> json) => _$AboutFromJson(json);

  @override
  String toString() {
    return 'About{stats: $stats, description: $description, title: $title, location: $location, links: $links, handle: $handle}';
  }
}

@JsonSerializable()
class Stats {
  final int? joinedDate;
  final int? viewCount;
  final int? subscriberCount;

  const Stats({
    this.joinedDate,
    this.viewCount,
    this.subscriberCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  @override
  String toString() {
    return 'Stats{joinedDate: $joinedDate, viewCount: $viewCount, subscriberCount: $subscriberCount}';
  }
}

@JsonSerializable()
class Link {
  final String? url;
  // TODO remove this line
  final String? thumbnail;
  final String? title;

  const Link({
    this.url,
    this.thumbnail,
    this.title,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  String toString() {
    return 'Link{url: $url, thumbnail: $thumbnail, title: $title}';
  }
}
