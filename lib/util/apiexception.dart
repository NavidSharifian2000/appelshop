class Apiexception implements Exception {
  int? code;
  String? message;
  Apiexception(this.code, this.message);
}
