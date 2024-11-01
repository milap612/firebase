import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/event/user_event.dart';
import 'package:firebase_demo/services/firebase_chat_service.dart';
import 'package:firebase_demo/state/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/chat_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ChatService chatService;

  UserBloc({required this.chatService}) : super(UserLoading()) {
    on<UsersFetching>(getAllUsers);
  }

  FutureOr<void> getAllUsers(
      UsersFetching event, Emitter<UserState> emit) async {
     emit(UserLoading());
    try {
      await emit.forEach(await chatService.getAllUser(),
          onData: ((List<Map<String, dynamic>> messages) {
        return UserSuccess(messages);
      }));
    } catch (e) {
      emit(UserError(e));
    }
  }

  User? getCurrentUser(){
    return chatService.getCurrentUser();
  }
}
