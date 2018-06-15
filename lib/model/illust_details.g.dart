// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illust_details.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

IllustDetails _$IllustDetailsFromJson(Map<String, dynamic> json) =>
    new IllustDetails(
        json['status'] as String,
        (json['response'] as List)
            ?.map((e) => e == null
                ? null
                : new Illustration.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        json['count'] as int);

abstract class _$IllustDetailsSerializerMixin {
  String get status;
  List<Illustration> get response;
  int get count;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'status': status, 'response': response, 'count': count};
}
