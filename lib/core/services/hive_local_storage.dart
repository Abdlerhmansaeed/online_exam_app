import 'package:hive_flutter/adapters.dart';

class HiveLocalStorage {
  static Future<void> hiveInit() async {
    await Hive.initFlutter();
  }

  static Future<Box> openBoxIfNeeded(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  Future<void> saveData(String key, dynamic value, String boxName) async {
    try {
      var box = await openBoxIfNeeded(boxName);

      if (value is List) {
        await box.put(key, value.map((e) => e.toJson()).toList());
      } else {
        await box.put(key, value);
      }

      print('Data saved successfully: $key -> $value');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  dynamic getData(String key, String boxName) {
    try {
      var box = Hive.box(boxName);
      var data = box.get(key);

      if (data == null) {
        print("No data found for key: $key");
        return [];
      }

      return data;
    } catch (e) {
      print('Error getting data: $e');
      return null;
    }
  }

  static Future<void> deleteData(String key, String boxName) async {
    try {
      var box = await openBoxIfNeeded(boxName);
      await box.delete(key);
      print("🗑Deleted data for key: $key");
    } catch (e) {
      print(' Error deleting data: $e');
    }
  }

  static Future<void> clearBox(String boxName) async {
    try {
      var box = await openBoxIfNeeded(boxName);
      await box.clear();
      print(" Cleared all data in box: $boxName");
    } catch (e) {
      print(' Error clearing box: $e');
    }
  }

  static Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
