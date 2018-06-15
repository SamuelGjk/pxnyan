import 'dart:async';
import 'dart:convert';
import 'package:pxnyan/model/illust_details.dart';
import 'package:pxnyan/model/member_illust.dart';
import 'package:pxnyan/model/rank.dart';
import 'package:http/http.dart' as http;

const String _URL_BASE = 'https://api.imjad.cn/pixiv/v1/';
const int _PAGE_SIZE = 20;
const Duration _TIMEOUT = const Duration(seconds: 20);
const Map<String, String> HEADER = {'Referer': 'https://www.pixiv.net/'};

Future<Rank> fetchRank(String mode, String date, int page) async {
  final response = await http
      .get('$_URL_BASE?type=rank&per_page=$_PAGE_SIZE&mode=$mode&date=$date&page=$page')
      .timeout(_TIMEOUT);
  final responseJson = json.decode(response.body);
  return new Rank.fromJson(responseJson);
}

Future<IllustDetails> fetchIllustDetails(int id) async {
  final response = await http.get('$_URL_BASE?type=illust&id=$id').timeout(_TIMEOUT);
  final responseJson = json.decode(response.body);
  return new IllustDetails.fromJson(responseJson);
}

Future<MemberIllust> fetchMemberIllust(int id, int page) async {
  print('$_URL_BASE?type=member_illust&per_page=$_PAGE_SIZE&page=$page&id=$id');
  final response = await http
      .get('$_URL_BASE?type=member_illust&per_page=$_PAGE_SIZE&page=$page&id=$id')
      .timeout(_TIMEOUT);
  final responseJson = json.decode(response.body);
  return new MemberIllust.fromJson(responseJson);
}

const String SUCCESS = 'success';
