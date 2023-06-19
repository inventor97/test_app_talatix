import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/repositories/_base_repo.dart';

class UserInfoRepository extends BaseRepository {
  Future<List<UserInfoModel>> getUsers() async {
    Response response = await makeHttpRequest("users", {});

    if (response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<UserInfoModel>.from(parsed?.map((e) => UserInfoModel.fromJson(e)) ?? []);
    }
    throw ("Error");
  }

  Future<List<UserAlbumsModel>> getUserAlbums(int userId) async {
    Response response = await makeHttpRequest("albums?userId=$userId", {});

    if (response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<UserAlbumsModel>.from(parsed?.map((e) => UserAlbumsModel.fromJson(e)) ?? []);
    }
    throw ("Error");
  }

  Future<List<UserPostsModel>> getUserPosts(int userId) async {
    Response response = await makeHttpRequest("posts?userId=$userId", {});

    if (response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<UserPostsModel>.from(parsed?.map((e) => UserPostsModel.fromJson(e)) ?? []);
    }

    throw ("Error");
  }

  Future<List<UserTodosModel>> getUserTodos(int userId) async {
    Response response = await makeHttpRequest("todos?userId=$userId", {});

    if (response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<UserTodosModel>.from(parsed?.map((e) => UserTodosModel.fromJson(e)) ?? []);
    }

    throw ("Error");
  }

  Future<List<PhotosModel>> getPhotos(int albumId) async {
    Response response = await makeHttpRequest("photos?albumId=$albumId", {});

    if (response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<PhotosModel>.from(parsed?.map((e) => PhotosModel.fromJson(e)) ?? []);
    }
    throw ("Error");
  }

  Future<List<CommentsModel>> getComments(int postId) async {
    Response response = await makeHttpRequest("comments?postId=$postId", {});

    if (response.statusCode == 200) {
      final parsed = await jsonDecode(utf8.decode(response.bodyBytes));
      return List<CommentsModel>.from(parsed?.map((e) => CommentsModel.fromJson(e)) ?? []);
    }
    throw ("Error");
  }
}
