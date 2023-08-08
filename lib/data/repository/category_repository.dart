import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/datasource/category_datasource.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/util/apiexception.dart';

abstract class Icategoryrepository {
  Future<Either<String, List<MainCategory>>> getCategories();
}

class categoryRepository extends Icategoryrepository {
  final Icategorydatasource _datasource = locator.get();
  @override
  Future<Either<String, List<MainCategory>>> getCategories() async {
    try {
      var respons = await _datasource.getCategoreis();
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }
}
