import 'package:equatable/equatable.dart';

import '../utils/form_submission_status.dart';

class AuthState extends Equatable {
  final String username;

  final String password;

  final FormSubmissionStatus formStatus;

  const AuthState(
      {this.username = '',
      this.password = '',
      this.formStatus = const FormInitialStatus()});

  @override
  List<Object?> get props => [username, password, formStatus];

  AuthState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return AuthState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
