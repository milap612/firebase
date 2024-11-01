import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/bloc/chat_bloc.dart';
import 'package:firebase_demo/services/firebase_chat_service.dart';
import 'package:firebase_demo/state/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/chat_event.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverUser, required this.receiverId});

  final String receiverUser;
  final String receiverId;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(receiverUser),
      ),
      body: BlocProvider(
        create: (context) => ChatBloc(
            chatService:
                FirebaseChatService(fireStore: FirebaseFirestore.instance)),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              context.read<ChatBloc>().add(ChatFetching(receiverId));
              return const CircularProgressIndicator();
            } else if (state is ChatError) {
              return Text(state.exception.toString());
            } else if (state is ChatSuccess) {
              final currentUser = context.read<ChatBloc>().getCurrentUser()!;
              return Stack(children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    final messageModel = state.messages[index];
                    final message = messageModel['message'];
                    final isCurrentUser =
                        messageModel['senderId'] == currentUser.uid;
                    final alignment = isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft;
                    return Align(
                      alignment: alignment,
                      child: Text(message),
                    );
                  },
                  itemCount: state.messages.length,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            context.read<ChatBloc>().add(
                                SendMessage(receiverId, _messageController));
                          },
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
//
// class ChatPage1 extends StatefulWidget {
//   const ChatPage1({
//     super.key,
//     required this.receiverUser,
//     required this.receiverId,
//     required this.userId,
//   });
//
//   final String receiverUser;
//   final String receiverId;
//   final String userId;
//
//   @override
//   State<ChatPage1> createState() => _ChatState();
// }
//
// class _ChatState extends State<ChatPage1> {
//   final TextEditingController _messageController = TextEditingController();
//   ChatService chatService =
//       FirebaseChatService(fireStore: FirebaseFirestore.instance);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.receiverUser),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
//               height: 60,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     height: 30,
//                     width: 30,
//                     decoration: BoxDecoration(
//                       color: Colors.lightBlue,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                           hintText: "Write message...",
//                           hintStyle: TextStyle(color: Colors.black54),
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                     },
//                     backgroundColor: Colors.blue,
//                     elevation: 0,
//                     child: const Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
