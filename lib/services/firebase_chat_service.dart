import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/models/message.dart';
import 'package:firebase_demo/services/chat_service.dart';

class FirebaseChatService implements ChatService {
  FirebaseChatService({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;
  final FirebaseFirestore _fireStore;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Stream<List<Map<String, dynamic>>>> getAllUser() async {
    return _fireStore.collection('Users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final user = doc.data();
            return user;
          },
        ).toList();
      },
    );
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<void> sendMessage(String receiverId, String message) async {
    final currentUser = getCurrentUser()!;
    final String currentUserId = currentUser.uid;
    final String currentUserEmail = currentUser.email!;
    final Timestamp timestamp = Timestamp.now();

    MessageModel messageModel = MessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timeStamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(messageModel.toJson());
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> receiveMessage(
      String senderId, receiverId) async{
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    final snapshots = _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();

    return snapshots.map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final chat = doc.data();
            return chat;
          },
        ).toList();
      },
    );
  }

// https://www.youtube.com/watch?v=5xU5WH2kEc0
}
