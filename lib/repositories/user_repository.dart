import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/repositories/_base_repo.dart';

class UserInfoRepository extends BaseRepository {
  
  Future<List<UserInfoModel>> getUsers() async {
    Response response = await makeHttpRequest("users", {});

    if(response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<UserInfoModel>.from(parsed?.map((e) => UserInfoModel.fromJson(e)) ?? []);
    }
    throw("Error");
  }
}