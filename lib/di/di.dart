import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_fluter/bloc/basket/basket_bloc.dart';
import 'package:shop_fluter/data/datasource/authentication_datasource.dart';
import 'package:shop_fluter/data/datasource/banner_datasource.dart';
import 'package:shop_fluter/data/datasource/basket_datasource.dart';
import 'package:shop_fluter/data/datasource/category_datasource.dart';
import 'package:shop_fluter/data/datasource/category_product_datasource.dart';
import 'package:shop_fluter/data/datasource/product_datasource.dart';
import 'package:shop_fluter/data/datasource/product_detail_datasource.dart';
import 'package:shop_fluter/data/repository/authentication_repository.dart';
import 'package:shop_fluter/data/repository/banner_repository.dart';
import 'package:shop_fluter/data/repository/basket_tepository.dart';
import 'package:shop_fluter/data/repository/category_repository.dart';
import 'package:shop_fluter/data/repository/categoryproduct_repository.dart';
import 'package:shop_fluter/data/repository/productDetail_repository.dart';
import 'package:shop_fluter/data/repository/product_repository.dart';

var locator = GetIt.instance;

Future<void> getInit() async {
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerFactory<Iauthentication>(() => AuthenticationRemote());
  locator.registerFactory<Iauthenticationrepository>(
      () => AuthenticatationRepository());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator
      .registerFactory<Icategorydatasource>(() => CategoryRemotdatasources());
  locator.registerFactory<Icategoryrepository>(() => categoryRepository());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDatasource());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IDetailsproductRepository>(() => DetailProduct());
  locator.registerFactory<IDetailProductDatasource>(
      () => DetailProductdatasource());
  locator.registerFactory<Icategoryproductdatasource>(
      () => categoryproductRemotedatasource());
  locator.registerFactory<IcategoryProductrepository>(
      () => categoryproductRepository());
  locator.registerFactory<IBasketDatasource>(() => BasketlocalDatasource());
  locator.registerFactory<IBasketRepository>(() => basketlocalrepository());

  //bloc
  locator.registerSingleton<BasketBloc>(BasketBloc());
}
