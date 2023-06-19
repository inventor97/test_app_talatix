import 'package:test_app_talatix/models/_storable.dart';

class UserTodosModel extends Storable<UserTodosModel> {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  UserTodosModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory UserTodosModel.fromJson(Map<String, dynamic> json) => UserTodosModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };

  @override
  UserTodosModel fromStoreJson(Map<String, dynamic> json) {
    return UserTodosModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toStoreJson() {
    return toJson();
  }
}

class UserAlbumsModel extends Storable<UserAlbumsModel> {
  final int? userId;
  final int? id;
  final String? title;

  UserAlbumsModel({
    this.userId,
    this.id,
    this.title,
  });

  factory UserAlbumsModel.fromJson(Map<String, dynamic> json) => UserAlbumsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };

  @override
  UserAlbumsModel fromStoreJson(Map<String, dynamic> json) {
    return UserAlbumsModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toStoreJson() {
    return toJson();
  }
}

class UserPostsModel extends Storable<UserPostsModel> {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  UserPostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory UserPostsModel.fromJson(Map<String, dynamic> json) => UserPostsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  UserPostsModel fromStoreJson(Map<String, dynamic> json) {
    return UserPostsModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toStoreJson() {
    return toJson();
  }
}

class PhotosModel {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  PhotosModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}

class CommentsModel {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  CommentsModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
