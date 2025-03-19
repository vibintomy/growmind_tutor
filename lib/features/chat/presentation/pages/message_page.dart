import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:growmind_tutuor/features/chat/presentation/widgets/chat_ui.dart';
import 'package:growmind_tutuor/features/home/domain/entities/notification_entities.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/notification_bloc.dart/notification_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/notification_bloc.dart/notification_event.dart';
import 'package:intl/intl.dart';

class MessagePage extends HookWidget {
  final String studentId;
  final String name;
  final String imageUrl;

  const MessagePage({
    super.key,
    required this.studentId,
    required this.imageUrl,
    required this.name,
  });
 
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser;
    final tutorId = userId!.uid;
    final messageController = useTextEditingController();
    final scrollController = useScrollController();

    
    void scrollToBottom() {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    // Hook for initialization
    useEffect(() {
      context.read<ChatBloc>().add(LoadMessages(studentId, tutorId));
      context.read<NotificationBloc>().add(SubscribeToUserTopic(tutorId));
      
      // Schedule a scroll to bottom after initial load
      Future.delayed(const Duration(milliseconds: 500), scrollToBottom);
      
      return () {
        messageController.dispose();
      };
    }, [studentId, tutorId]);

    void sendMessage() {
      final text = messageController.text.trim();
      if (text.isNotEmpty) {
        context.read<ChatBloc>().add(SendMessages(
            message: text, tutorId: tutorId, studentId: studentId));

        final notification = NotificationEntities(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            body: text,
            title: "New message from ${userId.displayName ?? 'User'}",
            receiverId: studentId,
            data: {'type': messageController.text, 'messageId': messageController.text},
            senderId: userId.uid,
            timeStamp: DateTime.now());
      
        context.read<NotificationBloc>().add(SendNotification(notification));
        messageController.clear();
        
        // Scroll to bottom after sending message
        scrollToBottom();
      }
    }

    // Helper function to format date for chat headers
   

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            kwidth,
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error : ${state.failure.message}')));
                }
                // Scroll to bottom when new messages are loaded
                if (state is ChatLoaded) {
                  scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatLoaded) {
                  return chatUi(context, scrollController, state, tutorId);
                } else if (state is MessageSending || state is MessageSent) {
                  if (state is ChatLoaded) {
                    return chatUi(context, scrollController, state, tutorId);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text('No messages yet'),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    filled: true,
                    fillColor: textColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  // Enable sending message on Enter key
                  onSubmitted: (_) => sendMessage(),
                )
              ),
              kwidth,
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: textColor, 
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}