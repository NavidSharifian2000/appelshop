import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/category/category_event.dart';
import 'package:shop_fluter/bloc/category/category_state.dart';
import 'package:shop_fluter/data/repository/category_repository.dart';
import 'package:shop_fluter/di/di.dart';

class CategoryBloc extends Bloc<CategoryEvent, CAtegoryState> {
  final Icategoryrepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryRequestList>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}
