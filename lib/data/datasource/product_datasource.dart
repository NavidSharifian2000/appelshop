import 'package:dio/dio.dart';
import 'package:shop_fluter/data/model/product.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/screens/home_screens.dart';

import '../../util/apiexception.dart';

abstract class IProductDatasource {
  Future<List<MainProduct>> getproduct();
  Future<List<MainProduct>> gethotest();
  Future<List<MainProduct>> getbestseller();
}

class ProductRemoteDatasource extends IProductDatasource {
  @override
  Future<List<MainProduct>> getproduct() async {
    final Dio _dio = locator.get();
    try {
      var response = await _dio.get("collections/products/records");
      var x = response.data['items']
          .map<MainProduct>((jsonObject) => MainProduct.fromjson(jsonObject))
          .toList();
      return x;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }

  @override
  Future<List<MainProduct>> getbestseller() async {
    final Dio _dio = locator.get();
    try {
      Map<String, String> Qparams = {'filter': 'popularity="Best Seller"'};
      var response = await _dio.get("collections/products/records",
          queryParameters: Qparams);
      var x = response.data['items']
          .map<MainProduct>((jsonObject) => MainProduct.fromjson(jsonObject))
          .toList();
      return x;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }

  @override
  Future<List<MainProduct>> gethotest() async {
    final Dio _dio = locator.get();
    try {
      Map<String, String> Qparams = {'filter': 'popularity="Hotest"'};
      var response = await _dio.get("collections/products/records",
          queryParameters: Qparams);
      var x = response.data['items']
          .map<MainProduct>((jsonObject) => MainProduct.fromjson(jsonObject))
          .toList();
      return x;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }
}
