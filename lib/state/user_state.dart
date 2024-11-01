import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserError extends UserState {
  final Object exception;

  UserError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class UserSuccess extends UserState {
  final List<Map<String, dynamic>> users;

  UserSuccess(this.users);

  @override
  List<Object?> get props => [users];
}
