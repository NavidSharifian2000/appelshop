import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/categoryProduct/categoryproduct_event.dart';
import 'package:shop_fluter/bloc/categoryProduct/categoryproduct_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/home/home_evenr.dart';
import 'package:shop_fluter/bloc/home/home_state.dart';
import 'package:shop_fluter/data/repository/banner_repository.dart';
import 'package:shop_fluter/data/repository/category_repository.dart';
import 'package:shop_fluter/data/repository/categoryproduct_repository.dart';
import 'package:shop_fluter/data/repository/product_repository.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/screens/home_screens.dart';

class categoryproductbloc
    extends Bloc<CategoryProductEvent, categoryProductState> {
  final IcategoryProductrepository _productrepository = locator.get();

  categoryproductbloc() : super(categoryproductloadinState()) {
    on<categoryProductInitialize>((Event, emit) async {
      var response = await _productrepository.getProductsbyId(Event.CategoryId);
      emit(categoryProductResponsesuccessState(response));
    });
  }
}
