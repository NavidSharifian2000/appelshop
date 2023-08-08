import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/product/product_event.dart';
import 'package:shop_fluter/bloc/product/product_state.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';
import 'package:shop_fluter/data/repository/basket_tepository.dart';
import 'package:shop_fluter/data/repository/productDetail_repository.dart';
import 'package:shop_fluter/di/di.dart';

class productbloc extends Bloc<ProductEvent, ProductState> {
  final IDetailsproductRepository _productRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();
  productbloc() : super(ProductInitstate()) {
    on<ProductInitEvent>((event, emit) async {
      emit(productloadingstate());
      var productimages =
          await _productRepository.getProductImage(event.productId);
      var productvariant =
          await _productRepository.getProductvariants(event.productId);
      var category =
          await _productRepository.getprodutcategory(event.CategoryId);
      print(category);
      var productpropertieslist =
          await _productRepository.getproperties(event.productId);
      print(productpropertieslist);
      emit(productResponsestate(
          productimages, productvariant, category, productpropertieslist));
    });
    on<ProductAddToBasket>(
      (event, emit) {
        var item = Basket_Item(
            event.product.id,
            event.product.collectionId,
            event.product.thumbnail,
            event.product.discountPrice,
            event.product.price,
            event.product.name,
            event.product.category);
        _basketRepository.addtobasket(item);
      },
    );
  }
}
