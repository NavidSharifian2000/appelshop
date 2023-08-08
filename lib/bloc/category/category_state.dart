import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_fluter/data/model/category.dart';

abstract class CAtegoryState {}

class CategoryInitState extends CAtegoryState {}

class CategoryResponseState extends CAtegoryState {
  Either<String, List<MainCategory>> Response;
  CategoryResponseState(this.Response);
}

class CategoryLoadingState extends CAtegoryState {}
