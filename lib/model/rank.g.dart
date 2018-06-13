// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Rank _$RankFromJson(Map<String, dynamic> json) => new Rank(
    json['status'] as String,
    (json['response'] as List)
        ?.map((e) =>
            e == null ? null : new Response.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
    json['pagination'] == null
        ? null
        : new Pagination.fromJson(json['pagination'] as Map<String, dynamic>));

abstract class _$RankSerializerMixin {
  String get status;
  List<Response> get response;
  int get count;
  Pagination get pagination;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'response': response,
        'count': count,
        'pagination': pagination
      };
}

Response _$ResponseFromJson(Map<String, dynamic> json) => new Response(
    json['content'] as String,
    json['mode'] as String,
    json['date'] as String,
    (json['works'] as List)
        ?.map((e) =>
            e == null ? null : new Work.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$ResponseSerializerMixin {
  String get content;
  String get mode;
  String get date;
  List<Work> get works;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'mode': mode,
        'date': date,
        'works': works
      };
}

Work _$WorkFromJson(Map<String, dynamic> json) => new Work(
    json['rank'] as int,
    json['work'] == null
        ? null
        : new WorkBean.fromJson(json['work'] as Map<String, dynamic>),
    json['previous_rank'] as int);

abstract class _$WorkSerializerMixin {
  int get rank;
  WorkBean get work;
  int get previousRank;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'rank': rank,
        'work': work,
        'previous_rank': previousRank
      };
}

WorkBean _$WorkBeanFromJson(Map<String, dynamic> json) => new WorkBean(
    json['id'] as int,
    json['title'] as String,
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    json['width'] as int,
    json['height'] as int,
    json['user'] == null
        ? null
        : new User.fromJson(json['user'] as Map<String, dynamic>),
    json['created_time'] as String,
    json['image_urls'] == null
        ? null
        : new ImageUrls.fromJson(json['image_urls'] as Map<String, dynamic>));

abstract class _$WorkBeanSerializerMixin {
  int get id;
  String get title;
  List<String> get tags;
  int get width;
  int get height;
  User get user;
  String get createdTime;
  ImageUrls get imageUrls;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'tags': tags,
        'width': width,
        'height': height,
        'user': user,
        'created_time': createdTime,
        'image_urls': imageUrls
      };
}

Pagination _$PaginationFromJson(Map<String, dynamic> json) => new Pagination(
    json['previous'] as int,
    json['next'] as int,
    json['current'] as int,
    json['per_page'] as int,
    json['total'] as int,
    json['pages'] as int);

abstract class _$PaginationSerializerMixin {
  int get previous;
  int get next;
  int get current;
  int get total;
  int get pages;
  int get perPage;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'previous': previous,
        'next': next,
        'current': current,
        'total': total,
        'pages': pages,
        'per_page': perPage
      };
}
