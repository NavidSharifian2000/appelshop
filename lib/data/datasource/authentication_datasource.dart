import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/util/apiexception.dart';

abstract class Iauthentication {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationRemote implements Iauthentication {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm
      });
    } on DioException catch (ex) {
      throw Apiexception(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw Apiexception(0, 'unknown erorr');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post('collections/users/auth-with-password',
          data: {'identity': username, 'password': password});
      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioException catch (ex) {
      throw (Apiexception(
          ex.response?.statusCode, ex.response?.data['message']));
    } catch (ex) {
      throw Apiexception(0, "unknow");
    }
    return '';
  }
}
