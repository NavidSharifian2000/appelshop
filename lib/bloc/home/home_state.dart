import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_fluter/data/model/banner.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/model/product.dart';

abstract class HomeState {}

class HomeInit extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<MainBanner>> bannerList;
  Either<String, List<MainCategory>> categoryList;
  Either<String, List<MainProduct>> product;
  Either<String, List<MainProduct>> hotestproduclist;
  Either<String, List<MainProduct>> bestseller;
  HomeResponseState(this.bannerList, this.categoryList, this.product,
      this.hotestproduclist, this.bestseller);
}
