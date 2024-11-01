import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatService{
  Future<Stream<List<Map<String, dynamic>>>> getAllUser();

  User? getCurrentUser();

  Future<void> sendMessage(String receiverId,String message);

  Future<Stream<List<Map<String, dynamic>>>> receiveMessage(String senderId,receiverId);
}