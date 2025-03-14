import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@injectable
class HiveLocalStorage {
 static  Future<void> hiveInit() async {
    await Hive.initFlutter();
  }

  static Future<void> openBox(String boxName) async {
    await Hive.openBox(boxName);
  }

   Future<void> saveData(String key, dynamic value, String boxName) async {
    try {
      var box = Hive.box(boxName);
      await box.put(key, value);
    } catch (e) {
      print('Error saving data: $e');
    }
  }

   dynamic getData(String key, String boxName) {
    try {
      var box = Hive.box(boxName);
      return box.get(key);
    } catch (e) {
      print('Error getting data: $e');
      return null;
    }
  }

  static Future<void> deleteData(String key, String boxName) async {
    try {
      var box = Hive.box(boxName);
      await box.delete(key);
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  static Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}