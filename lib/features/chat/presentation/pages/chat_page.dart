import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_event.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_state.dart';
import 'package:growmind_tutuor/features/chat/presentation/pages/message_page.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorId = FirebaseAuth.instance.currentUser;
    context.read<ConversationBloc>().add(LoadConversations(tutorId!.uid));
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text(
          'Chat inbox',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ConversationBloc, ConversationState>(
            builder: (context, state) {
          if (state is ConversationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ConversationLoaded) {
            if (state.conversations.isEmpty) {
              return const Center(
                child: Text('NO Conversations yet'),
              );
            }
            return ListView.builder(
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  final studentId = conversation.studentId;
                  final studentProfile = state.studentProfiles[studentId];
                  final studentName = studentProfile?.name ?? 'Unknown student';
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      conversation.lastMessageTime);
                  final formattedTime =
                      DateFormat('MM/dd HH:mm').format(dateTime);
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: studentProfile?.imageUrl != null
                              ? NetworkImage(studentProfile!.imageUrl!)
                              : null,
                        ),
                        title: Text(studentName),
                        subtitle: Text(formattedTime),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagePage(
                                    studentId: studentId,
                                      imageUrl: studentProfile!.imageUrl??'',
                                      name: studentName,
                                    )));
                        },
                      ),
                      const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: greyColor,
                      )
                    ],
                  );
                });
          } else if (state is ConversationError) {
            return Center(
              child: Text('Error :${state.failure.message}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
