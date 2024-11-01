import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/bloc/user_bloc.dart';
import 'package:firebase_demo/event/user_event.dart';
import 'package:firebase_demo/screen/chat_page.dart';
import 'package:firebase_demo/services/firebase_chat_service.dart';
import 'package:firebase_demo/state/user_state.dart';
import 'package:firebase_demo/widget/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'user list',
        ),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(
            chatService:
                FirebaseChatService(fireStore: FirebaseFirestore.instance)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              context.read<UserBloc>().add(UsersFetching());
              return const CircularProgressIndicator();
            } else if (state is UserSuccess) {
              final currentUser = context.read<UserBloc>().getCurrentUser()!;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  final receiverEmail = user['email'];
                  final receiverId = user['uid'];
                  if (receiverEmail != currentUser.email) {
                    return UserTile(
                      email: receiverEmail,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverUser: receiverEmail,
                              receiverId: receiverId,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                itemCount: state.users.length,
              );
            } else {
              return const Text('error');
            }
          },
        ),
      ),
    );
  }
}
