import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../../app_injections.dart';

@immutable
class GetStore implements CacheManager<GetStorage> {
  @override
  GetStorage get actor => get<GetStorage>();

  @override
  String? getString(String key) => actor.read(key);

  @override
  Future<bool> setString(String key, String value) => _write(key, value);

  @override
  int? getInt(String key) => actor.read<int>(key);

  @override
  Future<bool> setInt(String key, int value) => _write(key, value);
  @override
  bool? getBool(String key) => actor.read<bool>(key);

  @override
  Future<bool> setBool(String key, bool value) => _write(key, value);

  @override
  double? getDouble(String key) => actor.read<double>(key);

  @override
  Future<bool> setDouble(String key, double value) => _write(key, value);

  @override
  List<String>? getStringList(String key) => actor.read<List<String>>(key);

  @override
  Future<bool> setStringList(String key, List<String> value) => _write(key, value);

  @override
  Future<bool> remove(String key) {
    actor.remove(key);
    return Future.value(true);
  }

  @override
  Future<bool> clear() {
    actor.erase();
    return Future.value(true);
  }

  @override
  bool containsKey(String key) => actor.hasData(key);

  @override
  Set<String> getKeys() => actor.getKeys();

  Future<bool> _write(String key, dynamic value) {
    actor.write(key, value);
    return Future.value(true);
  }
}
