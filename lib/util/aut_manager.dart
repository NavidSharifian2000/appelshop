import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_fluter/di/di.dart';

class AuthManager {
  static final ValueNotifier<String?> AuthchangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharedpref = locator.get();
  static saveToken(String token) async {
    _sharedpref.setString("accesstoken", token);
    AuthchangeNotifire.value = token;
  }

  static String readAuth() {
    return _sharedpref.getString("accesstoken") ?? "";
  }

  static Void? logout() {
    _sharedpref.clear();
    AuthchangeNotifire.value = '';
  }
}
