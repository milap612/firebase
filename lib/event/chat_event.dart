import 'package:flutter/material.dart';

abstract class ChatEvent {}

class ChatFetching extends ChatEvent {
  String receiverId;

  ChatFetching(this.receiverId);
}

class SendMessage extends ChatEvent {
  String receiverId;
  TextEditingController message;

  SendMessage(this.receiverId,this.message);
}