import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState {}

class AuthStateInitainstate implements AuthState {}

class AuthStateLoadingstate implements AuthState {}

class AuthResponsestate extends AuthState {
  Either<String, String> respons;
  AuthResponsestate(this.respons);
}
