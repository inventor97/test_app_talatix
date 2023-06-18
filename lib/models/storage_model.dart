import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app_talatix/models/_storable.dart';
import 'package:test_app_talatix/models/models.dart';
import 'package:test_app_talatix/services/_base_storage.dart';

class StorableTypeModel<T extends Storable> extends BaseStorageService {
  Rx<T>? _data;
  RxList<T>? _list;
  final String key;
  final T? typeClass;

  StorableTypeModel({
    required this.key,
    this.typeClass,
  }) {
    _syncData();
  }

  set store(dynamic obj) {
    if (obj is T) {
      _data != null ? _data?.value = obj : _data = obj.obs;
      saveToDevice(key, obj.toStoreJson());
    } else if (obj is List<T>) {
      _list != null ? _list?.value = obj : _list = obj.obs;
      saveToDevice(key, List.from(_list?.map((e) => e.toStoreJson()) ?? []));
    }
  }

  void _syncData() {
    dynamic storedData = loadFromDevice(key);
    if (storedData is Map<String, dynamic>) {
      _data = typeClass!.fromStoreJson(storedData).obs;
    } else if (storedData is List) {
      try {
        _list = List<T>.from(storedData.map((e) => typeClass!.fromStoreJson(e))).obs;
      } catch (e) {
        Logger().e(e);
      }
    }
  }

  Rx<T>? get data {
    return _data;
  }

  RxList<T>? get list {
    return _list;
  }

  void addAll(List<T> objList) {
    if (_list != null) {
      _list?.addAll(objList);
    } else {
      _list = objList.obs;
    }
    saveToDevice(key, List.from(_list?.map((e) => e.toStoreJson()) ?? []));
  }

  void clear() {
    _data = null;
    _list?.clear();
    removeFromDevice(key);
  }

  void remove(T obj) {
    _list?.remove(obj);
    saveToDevice(key, List.from(_list?.map((e) => e.toStoreJson()) ?? []));
  }

  void update(int index, T obj) {
    _list![index] = obj;
    saveToDevice(key, List.from(_list?.map((e) => e.toStoreJson()) ?? []));
  }

  void add(T obj) {
    if (_list != null) {
      _list?.add(obj);
    } else {
      _list = [obj].obs;
    }
    saveToDevice(key, _list);
  }
}

class StorableCoreTypeModel<T> extends BaseStorageService {
  Rx<T>? _data;
  RxString? _stringValue;
  RxBool? _boolValue;
  RxDouble? _doubleValue;
  RxInt? _intValue;
  RxList<T>? _list;
  final String key;
  final EnumValues<T>? enumValues;

  StorableCoreTypeModel({
    required this.key,
    this.enumValues,
  }) {
    _syncData();
  }

  set store(dynamic obj) {
    if (enumValues != null) {
      if (obj is T) {
        _data != null ? _data?.value = obj : _data = obj.obs;
        saveToDevice(key, enumValues?.reverse![obj]);
      } else if (obj is List<T>) {
        _list != null ? _list?.value = obj : _list = obj.obs;
        saveToDevice(key, List.from(_list!.map((element) => enumValues?.reverse![element])));
      }
    } else {
      if (obj is List<T>) {
        if (_list != null) _list = obj.obs;
        saveToDevice(key, _list);
      } else {
        if (obj is String) {
          _stringValue != null ? _stringValue?.value = obj : _stringValue = obj.obs;
        } else if (obj is double) {
          _doubleValue != null ? _doubleValue?.value = obj : _doubleValue = obj.obs;
        } else if (obj is int) {
          _intValue != null ? _intValue?.value = obj : _intValue = obj.obs;
        } else if (obj is bool) {
          _boolValue != null ? _boolValue?.value = obj : _boolValue = obj.obs;
        } else if (obj is T) {
          _data != null ? _data?.value = obj : _data = obj.obs;
        }
        saveToDevice(key, obj);
      }
    }
  }

  void _syncData() {
    dynamic storedData = loadFromDevice(key);
    if (storedData != null) {
      if (enumValues != null) {
        if (enumValues?.map[storedData] != null && enumValues?.map[storedData] is T) _data = enumValues?.map[storedData]!.obs;
        if (storedData is List) _list = List<T>.from(storedData.map((e) => enumValues?.map[e])).obs;
      } else {
        if (storedData is String) {
          _stringValue = storedData.obs;
        } else if (storedData is double) {
          _doubleValue = storedData.obs;
        } else if (storedData is int) {
          _intValue = storedData.obs;
        } else if (storedData is bool) {
          _boolValue = storedData.obs;
        } else if (storedData is List) {
          _list = List<T>.from(storedData.map((e) => e)).obs;
        } else if (storedData is T) {
          _data = storedData.obs;
        }
      }
    }
  }

  Rx? get data {
    if (_stringValue != null) {
      return _stringValue;
    } else if (_doubleValue != null) {
      return _doubleValue;
    } else if (_intValue != null) {
      return _intValue;
    } else if (_boolValue != null) {
      return _boolValue;
    } else {
      return _data;
    }
  }

  RxList<T>? get list {
    return _list;
  }

  void addAll(List<T> objList) {
    if (_list != null) {
      _list?.addAll(objList);
    } else {
      _list = objList.obs;
    }
    saveToDevice(key, _list);
  }

  void clear() {
    _data = null;
    _list?.clear();
    removeFromDevice(key);
  }

  void remove(T obj) {
    _list?.remove(obj);
    saveToDevice(key, _list);
  }

  void add(T obj) {
    if (_list != null) {
      _list?.add(obj);
    } else {
      _list = [obj].obs;
    }
    saveToDevice(key, _list);
  }
}
