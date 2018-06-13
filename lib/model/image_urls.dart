import 'package:json_annotation/json_annotation.dart';

part 'image_urls.g.dart';

@JsonSerializable()
class ImageUrls extends Object with _$ImageUrlsSerializerMixin {
  @JsonKey(name: 'px_128x128') String px128x128;
  @JsonKey(name: 'px_480mw') String px480mw;
  String large;

  ImageUrls(this.px128x128, this.px480mw, this.large);

  factory ImageUrls.fromJson(Map<String, dynamic> json) => _$ImageUrlsFromJson(json);
}
