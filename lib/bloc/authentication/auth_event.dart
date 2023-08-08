abstract class AuthEvent {}

class AuthloginRequest extends AuthEvent {
  String username;
  String password;
  AuthloginRequest(this.username, this.password);
}
