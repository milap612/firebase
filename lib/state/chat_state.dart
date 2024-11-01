import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {}

class ChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatError extends ChatState {
  final Object exception;

  ChatError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class ChatSuccess extends ChatState {
  final List<Map<String, dynamic>> messages;

  ChatSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}