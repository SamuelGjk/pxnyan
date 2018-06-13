// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => new User(
    json['id'] as int,
    json['account'] as String,
    json['name'] as String,
    json['profile_image_urls'] == null
        ? null
        : new Avatar.fromJson(
            json['profile_image_urls'] as Map<String, dynamic>));

abstract class _$UserSerializerMixin {
  int get id;
  String get account;
  String get name;
  Avatar get profileImageUrls;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'account': account,
        'name': name,
        'profile_image_urls': profileImageUrls
      };
}

Avatar _$AvatarFromJson(Map<String, dynamic> json) =>
    new Avatar(json['px_170x170'] as String, json['px_50x50'] as String);

abstract class _$AvatarSerializerMixin {
  String get px170x170;
  String get px50x50;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'px_170x170': px170x170, 'px_50x50': px50x50};
}
