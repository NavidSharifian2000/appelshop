import 'package:shop_fluter/data/model/product.dart';

abstract class ProductEvent {}

class ProductInitEvent extends ProductEvent {
  String productId;
  String CategoryId;
  ProductInitEvent(this.productId, this.CategoryId);
}

class ProductAddToBasket extends ProductEvent {
  MainProduct product;
  ProductAddToBasket(this.product);
}
