import 'dart:ui';

import 'package:get/get.dart';
import 'package:test_app_talatix/i18n/Messages.dart';
import 'package:test_app_talatix/models/storage_model.dart';

import '_base_storage.dart';

class StorageService extends BaseStorageService {
  //storable data
  late StorableCoreTypeModel<String> lang = StorableCoreTypeModel(key: _fieldActiveLang);

  //non-storable data


  @override
  void onInit() {
    super.onInit();
    if (lang.data == null) lang.store = Messages.defaultLang.toString();
  }

  void changeLanguage(String lang) {
    Get.updateLocale(Locale(lang));

  }

  void clearAllData() {
    clearAll();
    onInit();
  }

  final String _fieldActiveLang = "_al";
}
