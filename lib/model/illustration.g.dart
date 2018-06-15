// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illustration.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Illustration _$IllustrationFromJson(Map<String, dynamic> json) =>
    new Illustration(
        json['id'] as int,
        json['title'] as String,
        json['caption'] as String,
        (json['tags'] as List)?.map((e) => e as String)?.toList(),
        json['image_urls'] == null
            ? null
            : new ImageUrls.fromJson(
                json['image_urls'] as Map<String, dynamic>),
        json['width'] as int,
        json['height'] as int,
        json['stats'] == null
            ? null
            : new Stats.fromJson(json['stats'] as Map<String, dynamic>),
        json['age_limit'] as String,
        json['created_time'] as String,
        json['user'] == null
            ? null
            : new User.fromJson(json['user'] as Map<String, dynamic>),
        json['is_manga'] as bool,
        json['page_count'] as int,
        json['metadata'] == null
            ? null
            : new Metadata.fromJson(json['metadata'] as Map<String, dynamic>));

abstract class _$IllustrationSerializerMixin {
  int get id;
  String get title;
  String get caption;
  List<String> get tags;
  ImageUrls get imageUrls;
  int get width;
  int get height;
  Stats get stats;
  String get ageLimit;
  String get createdTime;
  User get user;
  bool get isManga;
  int get pageCount;
  Metadata get metadata;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'caption': caption,
        'tags': tags,
        'image_urls': imageUrls,
        'width': width,
        'height': height,
        'stats': stats,
        'age_limit': ageLimit,
        'created_time': createdTime,
        'user': user,
        'is_manga': isManga,
        'page_count': pageCount,
        'metadata': metadata
      };
}

Stats _$StatsFromJson(Map<String, dynamic> json) => new Stats(
    json['scored_count'] as int,
    json['score'] as int,
    json['views_count'] as int,
    json['favorited_count'] == null
        ? null
        : new FavoritedCount.fromJson(
            json['favorited_count'] as Map<String, dynamic>),
    json['commented_count'] as int);

abstract class _$StatsSerializerMixin {
  int get scoredCount;
  int get score;
  int get viewsCount;
  FavoritedCount get favoritedCount;
  int get commentedCount;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'scored_count': scoredCount,
        'score': score,
        'views_count': viewsCount,
        'favorited_count': favoritedCount,
        'commented_count': commentedCount
      };
}

FavoritedCount _$FavoritedCountFromJson(Map<String, dynamic> json) =>
    new FavoritedCount(json['public'] as int, json['private'] as int);

abstract class _$FavoritedCountSerializerMixin {
  int get public;
  int get private;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'public': public, 'private': private};
}

Metadata _$MetadataFromJson(Map<String, dynamic> json) =>
    new Metadata((json['pages'] as List)
        ?.map((e) =>
            e == null ? null : new Page.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$MetadataSerializerMixin {
  List<Page> get pages;
  Map<String, dynamic> toJson() => <String, dynamic>{'pages': pages};
}

Page _$PageFromJson(Map<String, dynamic> json) =>
    new Page(json['image_urls'] == null
        ? null
        : new ImageUrls.fromJson(json['image_urls'] as Map<String, dynamic>));

abstract class _$PageSerializerMixin {
  ImageUrls get imageUrls;
  Map<String, dynamic> toJson() => <String, dynamic>{'image_urls': imageUrls};
}
