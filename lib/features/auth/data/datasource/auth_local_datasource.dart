import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getcacheUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String cachedUserKey = 'CACHED_USER';
  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      await prefs.setString(cachedUserKey, userJson);
    } catch (e) {
      throw Exception('failed to cache user $e');
    }
  }

  @override
  Future<UserModel?> getcacheUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(cachedUserKey);
      if (userJson != null) {
        final userMap = json.decode(userJson);
        return UserModel.fromFirebaseUser(userMap);
      }
      return null;
    } catch (e) {
      throw Exception('failed to retrieve');
    }
  }
}
