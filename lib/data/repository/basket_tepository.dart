import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/datasource/banner_datasource.dart';
import 'package:shop_fluter/data/datasource/basket_datasource.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';
import 'package:shop_fluter/data/model/banner.dart';

import '../../di/di.dart';
import '../../util/apiexception.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addtobasket(Basket_Item basket_item);
  Future<Either<String, List<Basket_Item>>> getAllBasketItem();
  Future<int> getfinalprice();
}

class basketlocalrepository extends IBasketRepository {
  final IBasketDatasource datasource = locator.get();

  @override
  Future<Either<String, String>> addtobasket(Basket_Item basket_item) async {
    try {
      datasource.addproduct(basket_item);
      return right("محصول به سبد خرید اضافه شد");
    } catch (e) {
      return left("خطا در افزودن به سبد خرید");
    }
  }

  @override
  Future<Either<String, List<Basket_Item>>> getAllBasketItem() async {
    try {
      var basketitemlist = await datasource.getAllBasketItem();
      return right(basketitemlist);
    } catch (e) {
      return left("با خطا مواجه شد");
    }
  }

  @override
  Future<int> getfinalprice() async {
    int finalprice = await datasource.getbasketfinalprice();
    return finalprice;
  }
}
