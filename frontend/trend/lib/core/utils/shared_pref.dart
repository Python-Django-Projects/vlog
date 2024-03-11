import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/authentication/data/models/user_model.dart';

class SharedPref {
  final SharedPreferences sharedPreferences;

  SharedPref({required this.sharedPreferences});

  String get languageCode =>
      sharedPreferences.getString('languageCode') ?? 'en';
  void setLanguageCode(String languageCode) {
    sharedPreferences.setString("languageCode", languageCode);
  }

  bool get isLoggedIn => account != null;

  void login(UserModel account) {
    sharedPreferences.clear();
    _setAccount(account);
  }

  Future<void> updateAccount(UserModel account) {
    return _setAccount(account);
  }

  Future<void> _setAccount(UserModel account) {
    return sharedPreferences.setString(
        'account', json.encode(account.toJson()));
  }

  UserModel? get account {
    if (sharedPreferences.getString('account') == null) {
      return null;
    }

    return UserModel.fromJson(
        json.decode(sharedPreferences.getString('account')!));
  }

  Future<void> clear() async {
    final lang = languageCode;
    await sharedPreferences.clear();
    setLanguageCode(lang);
  }

  void setThemeMode(ThemeMode mode) {
    sharedPreferences.setInt('themeMode', mode.index);
  }

  ThemeMode get themeMode =>
      ThemeMode.values[sharedPreferences.getInt('themeMode') ?? 0];
}
