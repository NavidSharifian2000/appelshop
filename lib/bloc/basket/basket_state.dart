import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';

abstract class BasketState {}

class Basketinitstate extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<Basket_Item>> basketItemlist;
  int basketfinalprice;
  BasketDataFetchedState(this.basketItemlist, this.basketfinalprice);
}
