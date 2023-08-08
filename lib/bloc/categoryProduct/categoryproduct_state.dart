import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_fluter/data/model/product.dart';

abstract class categoryProductState {}

class categoryproductloadinState extends categoryProductState {}

class categoryProductResponsesuccessState extends categoryProductState {
  Either<String, List<MainProduct>> productListBycategory;
  categoryProductResponsesuccessState(this.productListBycategory);
}
