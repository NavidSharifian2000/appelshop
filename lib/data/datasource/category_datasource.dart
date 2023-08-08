import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/util/apiexception.dart';

abstract class Icategorydatasource {
  Future<List<MainCategory>> getCategoreis();
}

class CategoryRemotdatasources extends Icategorydatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<MainCategory>> getCategoreis() async {
    try {
      var response = await _dio.get("collections/category/records");
      return response.data['items']
          .map<MainCategory>(
              (jsonObject) => MainCategory.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }
}
