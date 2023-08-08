import 'package:bloc/bloc.dart';
import 'package:shop_fluter/bloc/authentication/auth_event.dart';
import 'package:shop_fluter/bloc/authentication/auth_state.dart';
import 'package:shop_fluter/data/repository/authentication_repository.dart';
import 'package:shop_fluter/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Iauthenticationrepository _repsitory = locator.get();

  AuthBloc() : super(AuthStateInitainstate()) {
    on<AuthloginRequest>((event, emit) async {
      emit(AuthStateLoadingstate());
      var response = await _repsitory.login(event.username, event.password);
      emit(AuthResponsestate(response));
    });
  }
}
