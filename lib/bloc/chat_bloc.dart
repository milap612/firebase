import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/chat_event.dart';
import '../services/chat_service.dart';
import '../state/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;

  ChatBloc({required this.chatService}) : super(ChatLoading()) {
    on<ChatFetching>(getAllMessages);
    on<SendMessage>(sendMessage);
  }

  FutureOr<void> getAllMessages(
      ChatFetching event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      await emit.forEach(
          await chatService.receiveMessage(
              chatService.getCurrentUser()!.uid, event.receiverId),
          onData: ((List<Map<String, dynamic>> messages) {
        return ChatSuccess(messages);
      }));
    } catch (e) {
      emit(ChatError(e));
    }
  }

  FutureOr<void> sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    await chatService.sendMessage(event.receiverId, event.message.text);
    event.message.clear();
  }

  User? getCurrentUser(){
    return chatService.getCurrentUser();
  }
}
