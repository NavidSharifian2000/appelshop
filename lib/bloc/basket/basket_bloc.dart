import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/basket/basket_event.dart';
import 'package:shop_fluter/bloc/basket/basket_state.dart';

import '../../data/repository/basket_tepository.dart';
import '../../di/di.dart';

class BasketBloc extends Bloc<basketevent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();
  BasketBloc() : super(Basketinitstate()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketitemlist = await _basketRepository.getAllBasketItem();
        var finalprice = await _basketRepository.getfinalprice();
        emit(BasketDataFetchedState(basketitemlist, finalprice));
      },
    );
  }
}
