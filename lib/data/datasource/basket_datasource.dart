import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';

abstract class IBasketDatasource {
  Future<void> addproduct(Basket_Item basketitem);
  Future<List<Basket_Item>> getAllBasketItem();
  Future<int> getbasketfinalprice();
}

class BasketlocalDatasource extends IBasketDatasource {
  var box = Hive.box<Basket_Item>('cardbox');
  @override
  Future<void> addproduct(Basket_Item basketitem) async {
    box.add(basketitem);
  }

  @override
  Future<List<Basket_Item>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getbasketfinalprice() async {
    var productlist = await box.values.toList();

    int finalprice = productlist.fold(
        0, (previousValue, product) => previousValue += product.realprice!);
    return finalprice;
  }
}
