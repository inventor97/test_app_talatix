import 'dart:ui';

import 'package:get/get.dart';
import 'package:test_app_talatix/i18n/Messages.dart';
import 'package:test_app_talatix/models/storage_model.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/models/user_info_model.dart';

import '_base_storage.dart';

class StorageService extends BaseStorageService {

  //storable data
  late StorableCoreTypeModel<String> lang = StorableCoreTypeModel(key: _fieldActiveLang);
  late StorableTypeModel<UserInfoModel> users = StorableTypeModel(key: _fieldUsersInfo, typeClass: UserInfoModel());
  late StorableTypeModel<UserAlbumsModel> usersAlbums = StorableTypeModel(key: _fieldUsersAlbums, typeClass: UserAlbumsModel());
  late StorableTypeModel<UserPostsModel> usersPosts = StorableTypeModel(key: _fieldUsersPosts, typeClass: UserPostsModel());
  late StorableTypeModel<UserTodosModel> usersToDos = StorableTypeModel(key: _fieldUsersToDos, typeClass: UserTodosModel());

  //non-storable data
  final photos = <int, Map<int, List<PhotosModel>>>{}.obs;
  final comments = <int, Map<int, List<CommentsModel>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (lang.data == null) lang.store = Messages.defaultLang.toString();
  }

  void changeLanguage(String language) {
    lang.store = language;
    Get.updateLocale(Locale(language));
  }

  void clearAllData() {
    clearAll();
    onInit();
  }

  final String _fieldActiveLang = "_al";
  final String _fieldUsersInfo = "_ui";
  final String _fieldUsersAlbums = "_ua";
  final String _fieldUsersPosts = "_up";
  final String _fieldUsersToDos = "_ut";
}
