import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

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