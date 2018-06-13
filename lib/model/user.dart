import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Object with _$UserSerializerMixin {
  int id;
  String account;
  String name;
  @JsonKey(name: 'profile_image_urls') Avatar profileImageUrls;

  User(this.id, this.account, this.name, this.profileImageUrls);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Avatar extends Object with _$AvatarSerializerMixin {
  @JsonKey(name: 'px_170x170') String px170x170;
  @JsonKey(name: 'px_50x50') String px50x50;

  Avatar(this.px170x170, this.px50x50);

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}
