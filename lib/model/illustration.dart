import 'package:json_annotation/json_annotation.dart';
import 'package:pxnyan/model/image_urls.dart';
import 'package:pxnyan/model/user.dart';

part 'illustration.g.dart';


@JsonSerializable()
class Illustration extends Object with _$IllustrationSerializerMixin {
  int id;
  String title;
  String caption;
  List<String> tags;
  @JsonKey(name: 'image_urls') ImageUrls imageUrls;
  int width;
  int height;
  Stats stats;
  @JsonKey(name: 'age_limit') String ageLimit;
  @JsonKey(name: 'created_time') String createdTime;
  User user;
  @JsonKey(name: 'is_manga') bool isManga;
  @JsonKey(name: 'page_count') int pageCount;
  Metadata metadata;

  Illustration(this.id, this.title, this.caption, this.tags, this.imageUrls, this.width,
      this.height, this.stats, this.ageLimit, this.createdTime, this.user, this.isManga,
      this.pageCount, this.metadata);

  factory Illustration.fromJson(Map<String, dynamic> json) => _$IllustrationFromJson(json);
}

@JsonSerializable()
class Stats extends Object with _$StatsSerializerMixin {
  @JsonKey(name: 'scored_count') int scoredCount;
  int score;
  @JsonKey(name: 'views_count') int viewsCount;
  @JsonKey(name: 'favorited_count') FavoritedCount favoritedCount;
  @JsonKey(name: 'commented_count') int commentedCount;

  Stats(this.scoredCount, this.score, this.viewsCount, this.favoritedCount, this.commentedCount);

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}

@JsonSerializable()
class FavoritedCount extends Object with _$FavoritedCountSerializerMixin {
  int public;
  int private;

  FavoritedCount(this.public, this.private);

  factory FavoritedCount.fromJson(Map<String, dynamic> json) => _$FavoritedCountFromJson(json);
}

@JsonSerializable()
class Metadata extends Object with _$MetadataSerializerMixin {
  List<Page> pages;

  Metadata(this.pages);

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);
}

@JsonSerializable()
class Page extends Object with _$PageSerializerMixin {
  @JsonKey(name: 'image_urls') ImageUrls imageUrls;

  Page(this.imageUrls);

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
}