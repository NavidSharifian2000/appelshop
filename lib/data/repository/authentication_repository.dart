import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_fluter/data/datasource/authentication_datasource.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shop_fluter/util/apiexception.dart';
import 'package:shop_fluter/util/aut_manager.dart';

abstract class Iauthenticationrepository {
  Future<Either<String, String>> Register();
  Future<Either<String, String>> login(String username, String password);
}

class AuthenticatationRepository implements Iauthenticationrepository {
  final Iauthentication _datasource = locator.get();
  final SharedPreferences _SharedPref = locator.get();

  @override
  Future<Either<String, String>> Register() async {
    try {
      await _datasource.register("navidsh", "123456789", "123456789");
      return right("done");
    } on Apiexception catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right("شما وارد شدید");
      } else {
        return left("خطایی در ورود پیش اومده");
      }
    } on Apiexception catch (ex) {
      return left(ex.message.toString());
    }
  }
}
