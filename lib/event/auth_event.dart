import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class UserNameChange extends AuthEvent {
  final String? username;

  UserNameChange(this.username);

  @override
  List<Object?> get props => [username];
}

class PasswordChange extends AuthEvent {
  final String? password;

  PasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends AuthEvent {
  final String username;
  final String password;

  LoginSubmitted(this.username,this.password);

  @override
  List<Object?> get props => [username,password];
}

class RegisterSubmitted extends AuthEvent {
  final String? username;
  final String? password;

  RegisterSubmitted(this.username, this.password);

  @override
  List<Object?> get props => [username,password];
}
