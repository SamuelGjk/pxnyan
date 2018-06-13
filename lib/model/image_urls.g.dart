// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_urls.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

ImageUrls _$ImageUrlsFromJson(Map<String, dynamic> json) => new ImageUrls(
    json['px_128x128'] as String,
    json['px_480mw'] as String,
    json['large'] as String);

abstract class _$ImageUrlsSerializerMixin {
  String get px128x128;
  String get px480mw;
  String get large;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'px_128x128': px128x128,
        'px_480mw': px480mw,
        'large': large
      };
}
