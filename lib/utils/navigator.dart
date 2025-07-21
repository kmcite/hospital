import 'dart:convert';

import 'package:states_rebuilder/states_rebuilder.dart' show RM;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hospital/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

final navigator = RM.navigate;

abstract class KeyValueStore {
  Future<void> setItem(String key, String value);
  Future<String?> getItem(String key);
  Future<void> removeItem(String key);
}

class HiveKeyStore extends KeyValueStore {
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    final appInfo = await PackageInfo.fromPlatform();
    _box = await Hive.openBox(appInfo.appName);
  }

  @override
  Future<String?> getItem(String key) {
    return _box.get(key);
  }

  @override
  Future<void> removeItem(String key) {
    return _box.delete(key);
  }

  @override
  Future<void> setItem(String key, String value) {
    return _box.put(key, value);
  }
}

abstract class PersistedSignal<T> extends FlutterSignal<T>
    with PersistedSignalMixin<T> {
  PersistedSignal(
    super.internalValue, {
    super.autoDispose,
    super.debugLabel,
    required this.key,
    required this.store,
  });

  @override
  final String key;

  @override
  final KeyValueStore store;
}

mixin PersistedSignalMixin<T> on Signal<T> {
  String get key;
  KeyValueStore get store;

  bool loaded = false;

  Future<void> init() async {
    try {
      final val = await load();
      super.value = val;
    } catch (e) {
      debugPrint('Error loading persisted signal: $e');
    } finally {
      loaded = true;
    }
  }

  @override
  T get value {
    if (!loaded) init().ignore();
    return super.value;
  }

  @override
  set value(T value) {
    super.value = value;
    save(value).ignore();
  }

  Future<T> load() async {
    final val = await store.getItem(key);
    if (val == null) return value;
    return decode(val);
  }

  Future<void> save(T value) async {
    final str = encode(value);
    await store.setItem(key, str);
  }

  T decode(String value) => jsonDecode(value);

  String encode(T value) => jsonEncode(value);
}
