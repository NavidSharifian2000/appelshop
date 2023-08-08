import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/model/product.dart';

import '../../di/di.dart';
import '../../util/apiexception.dart';
import '../datasource/category_product_datasource.dart';
import '../model/category.dart';

abstract class IcategoryProductrepository {
  Future<Either<String, List<MainProduct>>> getProductsbyId(String categoryId);
}

class categoryproductRepository extends IcategoryProductrepository {
  final Icategoryproductdatasource _datasource = locator.get();
  @override
  Future<Either<String, List<MainProduct>>> getProductsbyId(
      String categoryId) async {
    try {
      var response = await _datasource.getproductBycategoryId(categoryId);
      return right(response);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }
}
