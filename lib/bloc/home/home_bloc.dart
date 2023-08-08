import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/home/home_evenr.dart';
import 'package:shop_fluter/bloc/home/home_state.dart';
import 'package:shop_fluter/data/repository/banner_repository.dart';
import 'package:shop_fluter/data/repository/category_repository.dart';
import 'package:shop_fluter/data/repository/product_repository.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/screens/home_screens.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerrepository = locator.get();
  final Icategoryrepository _category = locator.get();
  final IProductRepository _productReposirory = locator.get();
  HomeBloc() : super(HomeInit()) {
    on<HomeInitData>((Event, emit) async {
      emit(HomeLoadingState());
      var bannerlist = await bannerrepository.getBanners();
      var categorylist = await _category.getCategories();
      var productlist = await _productReposirory.getproducts();

      var hotestproductlist = await _productReposirory.getHotest();
      var bestseller = await _productReposirory.getbestseller();
      emit(HomeResponseState(bannerlist, categorylist, productlist,
          hotestproductlist, bestseller));
    });
  }
}
