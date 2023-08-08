import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/model/product_inages.dart';
import 'package:shop_fluter/data/model/product_property.dart';
import 'package:shop_fluter/data/model/product_variant.dart';
import 'package:shop_fluter/data/model/variant.dart';
import 'package:shop_fluter/data/model/variant_type.dart';
import 'package:shop_fluter/di/di.dart';

import '../../util/apiexception.dart';

abstract class IDetailProductDatasource {
  Future<List<MainproductImage>> getgallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<variant>> getVariant(String variantid);
  Future<List<productVAriant>> getproductvariant(String variantid);
  Future<MainCategory> getproductcategory(String categoryid);
  Future<List<Property>> getproperties(String productid);
}

class DetailProductdatasource extends IDetailProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<MainproductImage>> getgallery(String productId) async {
    try {
      print(productId + "---------------");
      Map<String, String> Qparams = {'filter': 'product_id="$productId"'};
      var response = await _dio.get("collections/gallery/records",
          queryParameters: Qparams);
      List<MainproductImage> x = response.data['items']
          .map<MainproductImage>(
              (jsonObject) => MainproductImage.fromjson(jsonObject))
          .toList();
      return x;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get("collections/variants_type/records");
      var x = response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromjson(jsonObject))
          .toList();
      return x;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }

  @override
  Future<List<variant>> getVariant(String variantid) async {
    try {
      Map<String, String> Qparams = {'filter': 'product_id="$variantid"'};
      var response = await _dio.get("collections/variants/records",
          queryParameters: Qparams);
      var x = response.data['items']
          .map<variant>((jsonObject) => variant.fromjson(jsonObject))
          .toList();
      return x;
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }

  @override
  Future<List<productVAriant>> getproductvariant(String variantid) async {
    var varianttypelist = await getVariantTypes();
    var variantlist = await getVariant(variantid);
    List<productVAriant> productvariantList = [];
    for (var varianttype in varianttypelist) {
      var variantoption = variantlist
          .where((element) => element.typeId == varianttype.id)
          .toList();
      productvariantList.add(productVAriant(varianttype, variantoption));
    }
    return productvariantList;
  }

  @override
  Future<MainCategory> getproductcategory(String categoryid) async {
    try {
      Map<String, String> Qparams = {'filter': 'id="$categoryid"'};
      var response = await _dio.get("collections/category/records",
          queryParameters: Qparams);
      return MainCategory.fromMapJson(response.data["items"][0]);
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }

  @override
  Future<List<Property>> getproperties(String productid) async {
    try {
      Map<String, String> Qparams = {'filter': 'product_id="$productid"'};
      var response = await _dio.get("collections/properties/records",
          queryParameters: Qparams);
      print(response);
      return response.data["items"]
          .map<Property>((json) => Property.fromjson(json))
          .toList();
    } on DioException catch (ex) {
      throw Apiexception(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw Apiexception(0, "unknowerror");
    }
  }
}
