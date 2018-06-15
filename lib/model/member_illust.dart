import 'package:json_annotation/json_annotation.dart';
import 'package:pxnyan/model/illustration.dart';
import 'package:pxnyan/model/pagination.dart';

part 'member_illust.g.dart';

@JsonSerializable()
class MemberIllust extends Object with _$MemberIllustSerializerMixin {
  String status;
  List<Illustration> response;
  int count;
  Pagination pagination;

  MemberIllust(this.status, this.response, this.count, this.pagination);

  factory MemberIllust.fromJson(Map<String, dynamic> json) => _$MemberIllustFromJson(json);
}
