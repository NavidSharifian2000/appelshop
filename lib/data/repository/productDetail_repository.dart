import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/datasource/product_detail_datasource.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/model/product_inages.dart';
import 'package:shop_fluter/data/model/product_property.dart';
import 'package:shop_fluter/data/model/product_variant.dart';
import 'package:shop_fluter/data/model/variant_type.dart';
import 'package:shop_fluter/di/di.dart';

import '../../util/apiexception.dart';

abstract class IDetailsproductRepository {
  Future<Either<String, List<MainproductImage>>> getProductImage(
      String productId);
  Future<Either<String, List<VariantType>>> varianttypes();
  Future<Either<String, List<productVAriant>>> getProductvariants(
      String variantid);
  Future<Either<String, MainCategory>> getprodutcategory(String categoryid);
  Future<Either<String, List<Property>>> getproperties(String categoryid);
}

class DetailProduct extends IDetailsproductRepository {
  final IDetailProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<MainproductImage>>> getProductImage(
      String productId) async {
    try {
      var respons = await _datasource.getgallery(productId);
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }

  @override
  Future<Either<String, List<VariantType>>> varianttypes() async {
    try {
      var respons = await _datasource.getVariantTypes();
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }

  @override
  Future<Either<String, List<productVAriant>>> getProductvariants(
      String variantid) async {
    try {
      var respons = await _datasource.getproductvariant(variantid);
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }

  @override
  Future<Either<String, MainCategory>> getprodutcategory(
      String categoryid) async {
    try {
      var respons = await _datasource.getproductcategory(categoryid);
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }

  @override
  Future<Either<String, List<Property>>> getproperties(String productid) async {
    try {
      var respons = await _datasource.getproperties(productid);
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }
}
