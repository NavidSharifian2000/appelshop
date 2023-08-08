import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/datasource/banner_datasource.dart';
import 'package:shop_fluter/data/model/banner.dart';

import '../../di/di.dart';
import '../../util/apiexception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<MainBanner>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource bannerdatasource = locator.get();

  @override
  Future<Either<String, List<MainBanner>>> getBanners() async {
    try {
      var respons = await bannerdatasource.getBanners();
      return right(respons);
    } on Apiexception catch (ex) {
      return left(ex.message ?? "خطا محتوای متنی ندارد");
    }
  }
}
