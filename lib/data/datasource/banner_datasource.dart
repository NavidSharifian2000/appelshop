import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_fluter/data/model/banner.dart';
import 'package:shop_fluter/di/di.dart';

import '../../util/apiexception.dart';

abstract class IBannerDatasource {
  Future<List<MainBanner>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  @override
  Future<List<MainBanner>> getBanners() async {
    final Dio _dio = locator.get();
    try {
      var response = await _dio.get("collections/banner/records");
      var response2 = response.data["items"];
      List<MainBanner> a = [];
      List<dynamic> x = response.data['items']
          .map((jsonObject) => MainBanner.fromMapJson(jsonObject))
          .toList();
      a = x.cast<MainBanner>();
      return a;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }
}
