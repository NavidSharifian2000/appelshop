import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/datasource/product_datasource.dart';
import 'package:shop_fluter/data/model/product.dart';

import '../../di/di.dart';
import '../../util/apiexception.dart';

abstract class IProductRepository {
  Future<Either<String, List<MainProduct>>> getproducts();
  Future<Either<String, List<MainProduct>>> getHotest();
  Future<Either<String, List<MainProduct>>> getbestseller();
}

class ProductRepository extends IProductRepository {
  final IProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<MainProduct>>> getproducts() async {
    try {
      var respons = await _datasource.getproduct();
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }

  @override
  Future<Either<String, List<MainProduct>>> getHotest() async {
    try {
      var respons = await _datasource.gethotest();
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }

  @override
  Future<Either<String, List<MainProduct>>> getbestseller() async {
    try {
      var respons = await _datasource.getbestseller();
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }
}
