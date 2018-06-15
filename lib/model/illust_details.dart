import 'package:json_annotation/json_annotation.dart';
import 'package:pxnyan/model/image_urls.dart';
import 'package:pxnyan/model/user.dart';
import 'package:pxnyan/model/illustration.dart';

part 'illust_details.g.dart';

@JsonSerializable()
class IllustDetails extends Object with _$IllustDetailsSerializerMixin {
  String status;
  List<Illustration> response;
  int count;

  IllustDetails(this.status, this.response, this.count);

  factory IllustDetails.fromJson(Map<String, dynamic> json) => _$IllustDetailsFromJson(json);
}