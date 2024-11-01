import 'package:firebase_demo/utils/form_submission_status.dart';
import 'package:firebase_demo/event/auth_event.dart';
import 'package:firebase_demo/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService? authService;

  AuthBloc({required this.authService}) : super(const AuthState()) {
    on<AuthEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is UserNameChange) {
      emit(state.copyWith(username: event.username));
    } else if (event is PasswordChange) {
      emit(state.copyWith(password: event.password));
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmittingStatus()));

      try {
        await authService?.signInWithEmailAndPassword(
          email: event.username,
          password: event.password,
        );

        emit(state.copyWith(formStatus: FormSuccessStatus()));
      } catch (e) {
        emit(state.copyWith(formStatus: FormFailStatus(e)));
      }
    }else if (event is RegisterSubmitted) {
      emit(state.copyWith(formStatus: FormSubmittingStatus()));

      try {
        await authService?.createUserWithEmailAndPassword(
            email: state.username, password: state.password);
        emit(state.copyWith(formStatus: FormSuccessStatus()));
      } catch (e) {
        emit(state.copyWith(formStatus: FormFailStatus(e)));
      }
    }
  }

}
