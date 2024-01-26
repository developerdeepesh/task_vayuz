import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'hive_utils.dart';

class HiveLocalDB {

  // Hive constant String
  static const String hiveDataBase = "HiveDatabase";

  // Hive Tables
  static const String todoList = "todoList";

  read(String key) async {
    Box box = await HiveUtil.openBox(HiveLocalDB.hiveDataBase);

    final value = box.get(key);
    if (value != null) return json.decode(value);
    return null;
  }

  save(String key, value) async {
    try {
      Box box = await HiveUtil.openBox(HiveLocalDB.hiveDataBase);
      await box.put(key, json.encode(value));
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  delete(String key) async {
    try {
      Box box = await HiveUtil.openBox(HiveLocalDB.hiveDataBase);
      await box.delete(key);
    } catch (e) {
      debugPrint(e as String?);
    }
  }
}
