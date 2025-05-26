import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/app_manger/app_local_storage/app_local_storage.dart';
import 'dart:developer' as dev;

@Injectable(as: AppLocalStorage)
class AppLocalStorageImpl implements AppLocalStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userDataPrefix = 'user_data_';

  @override
  Future<void> clearAllData() async {
    dev.log('Clearing all secure storage data', name: 'AppLocalStorage');
    try {
      await _secureStorage.deleteAll();
      dev.log('All secure storage data cleared successfully',
          name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error clearing secure storage data',
          error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<String?> getToken() async {
    dev.log('Getting auth token from secure storage', name: 'AppLocalStorage');
    try {
      final token = await _secureStorage.read(key: _tokenKey);
      dev.log(
          'Auth token retrieved: ${token != null ? '[TOKEN EXISTS]' : 'null'}',
          name: 'AppLocalStorage');
      return token;
    } catch (e) {
      dev.log('Error getting auth token', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<String?> getUserData(String key) async {
    dev.log('Getting user data for key: $key', name: 'AppLocalStorage');
    try {
      final data = await _secureStorage.read(key: _userDataPrefix + key);
      dev.log(
          'User data retrieved for $key: ${data != null ? '[DATA EXISTS]' : 'null'}',
          name: 'AppLocalStorage');
      return data;
    } catch (e) {
      dev.log('Error getting user data for $key',
          error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<String?> getUserId() async {
    dev.log('Getting user ID from secure storage', name: 'AppLocalStorage');
    try {
      final userId = await _secureStorage.read(key: _userIdKey);
      dev.log('User ID retrieved: ${userId ?? 'null'}',
          name: 'AppLocalStorage');
      return userId;
    } catch (e) {
      dev.log('Error getting user ID', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> removeToken() async {
    dev.log('Removing auth token from secure storage', name: 'AppLocalStorage');
    try {
      await _secureStorage.delete(key: _tokenKey);
      dev.log('Auth token removed successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error removing auth token', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> removeUserData(String key) async {
    dev.log('Removing user data for key: $key', name: 'AppLocalStorage');
    try {
      await _secureStorage.delete(key: _userDataPrefix + key);
      dev.log('User data for $key removed successfully',
          name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error removing user data for $key',
          error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> removeUserId() async {
    dev.log('Removing user ID from secure storage', name: 'AppLocalStorage');
    try {
      await _secureStorage.delete(key: _userIdKey);
      dev.log('User ID removed successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error removing user ID', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    dev.log('Saving auth token to secure storage', name: 'AppLocalStorage');
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
      dev.log('Auth token saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error saving auth token', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(String key, String value) async {
    dev.log('Saving user data: $key', name: 'AppLocalStorage');
    try {
      await _secureStorage.write(key: _userDataPrefix + key, value: value);
      dev.log('User data for $key saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error saving user data for $key',
          error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> saveUserId(String userId) async {
    dev.log('Saving user ID: $userId to secure storage',
        name: 'AppLocalStorage');
    try {
      await _secureStorage.write(key: _userIdKey, value: userId);
      dev.log('User ID saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error saving user ID', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<bool> saveRememberMe(bool value) async {
    await _secureStorage.write(key: 'rememberMe', value: value.toString());
    return value;
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await _secureStorage.read(key: 'rememberMe');
    if (value != null) {
      return value == 'true';
    } else {
      return false;
    }
  }
}
