import 'package:dio/dio.dart';
import 'package:shop_fluter/data/model/product.dart';

import '../../di/di.dart';
import '../../util/apiexception.dart';

abstract class Icategoryproductdatasource {
  Future<List<MainProduct>> getproductBycategoryId(String categoryId);
}

class categoryproductRemotedatasource extends Icategoryproductdatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<MainProduct>> getproductBycategoryId(String categoryId) async {
    try {
      Map<String, String> Qparams = {'filter': 'category="$categoryId"'};
      var response = await _dio.get("collections/products/records",
          queryParameters: Qparams);
      print(response);
      return response.data["items"]
          .map<MainProduct>((json) => MainProduct.fromjson(json))
          .toList();
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }
}
