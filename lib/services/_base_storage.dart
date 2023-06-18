import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:logger/logger.dart';

class BaseStorageService extends GetxService {

  final iv = encrypt.IV.fromLength(16);
  encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8("nxNMqCfmfFH9tIwfxCViHyGzMJqH4Zjh")));

  final store = <String, Rx<dynamic>>{}.obs;

  final box = GetStorage();

  dynamic loadFromDevice(String key) {
    try {
      encrypt.Encrypted data = encrypt.Encrypted.fromBase64(box.read(key));
      return jsonDecode(encrypter.decrypt(data, iv: iv));
    } catch (e) {
      Logger().e("Error on reading storage key $key =>'$e'");
    }
  }

  void saveToDevice(String key, dynamic value) {
    try {
      var data = encrypter.encrypt(jsonEncode(value), iv: iv);
      box.write(key, data.base64);
      Logger().w("$key $value");
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  void removeFromDevice(String key) {
    try {
      box.remove(key);
      Logger().d("under the $key key data removed from storage");
    }catch(e) {
      Logger().e(e);
    }
  }

  void clearAll() {
    box.erase();
  }

}
