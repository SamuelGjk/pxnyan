import 'package:json_annotation/json_annotation.dart';
import 'package:pxnyan/model/image_urls.dart';
import 'package:pxnyan/model/user.dart';

part 'rank.g.dart';

@JsonSerializable()
class Rank extends Object with _$RankSerializerMixin {
  String status;
  List<Response> response;
  int count;
  Pagination pagination;

  Rank(this.status, this.response, this.count, this.pagination);

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);
}

@JsonSerializable()
class Response extends Object with _$ResponseSerializerMixin {
  String content;
  String mode;
  String date;
  List<Work> works;

  Response(this.content, this.mode, this.date, this.works);

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
}

@JsonSerializable()
class Work extends Object with _$WorkSerializerMixin {
  int rank;
  WorkBean work;
  @JsonKey(name: 'previous_rank') int previousRank;

  Work(this.rank, this.work, this.previousRank);

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
}

@JsonSerializable()
class WorkBean extends Object with _$WorkBeanSerializerMixin {
  int id;
  String title;
  List<String> tags;
  int width;
  int height;
  User user;
  @JsonKey(name: 'created_time') String createdTime;
  @JsonKey(name: 'image_urls') ImageUrls imageUrls;

  WorkBean(this.id, this.title, this.tags, this.width, this.height, this.user, this.createdTime, this.imageUrls);

  factory WorkBean.fromJson(Map<String, dynamic> json) => _$WorkBeanFromJson(json);
}

@JsonSerializable()
class Pagination extends Object with _$PaginationSerializerMixin {
  int previous;
  int next;
  int current;
  int total;
  int pages;
  @JsonKey(name: 'per_page') int perPage;

  Pagination(this.previous, this.next, this.current, this.perPage, this.total, this.pages);

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
}
