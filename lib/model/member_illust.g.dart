// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_illust.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

MemberIllust
    _$MemberIllustFromJson(Map<String, dynamic> json) =>
        new MemberIllust(
            json['status'] as String,
            (json['response'] as List)
                ?.map((e) => e == null
                    ? null
                    : new Illustration.fromJson(e as Map<String, dynamic>))
                ?.toList(),
            json['count'] as int,
            json['pagination'] == null
                ? null
                : new Pagination.fromJson(
                    json['pagination'] as Map<String, dynamic>));

abstract class _$MemberIllustSerializerMixin {
  String get status;
  List<Illustration> get response;
  int get count;
  Pagination get pagination;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'response': response,
        'count': count,
        'pagination': pagination
      };
}
