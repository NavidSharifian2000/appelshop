import 'package:dartz/dartz.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/model/product_inages.dart';
import 'package:shop_fluter/data/model/product_property.dart';
import 'package:shop_fluter/data/model/product_variant.dart';
import 'package:shop_fluter/data/model/variant_type.dart';

abstract class ProductState {}

class ProductInitstate extends ProductState {}

class productloadingstate extends ProductState {}

class productResponsestate extends ProductState {
  Either<String, List<MainproductImage>> getproductImage;
  Either<String, List<productVAriant>> getproductvariants;
  Either<String, MainCategory> productcategory;
  Either<String, List<Property>> properties;
  productResponsestate(this.getproductImage, this.getproductvariants,
      this.productcategory, this.properties);
}
