// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

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
