import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:intl/intl.dart';

class MessagePage extends HookWidget {  // Changed to HookWidget
  final String name;
  final String imageUrl;
  final String receiverId;

  const MessagePage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final scrollController = useScrollController();
    
    // Hook for initialization
    useEffect(() {
      final userId = FirebaseAuth.instance.currentUser;
      context.read<ChatBloc>().add(LoadMessages(receiverId, userId!.uid));
      return null;
    }, []);

    void sendMessage() {
      final userId = FirebaseAuth.instance.currentUser;
      final text = messageController.text.trim();
      if (text.isNotEmpty) {
        final message = Message(
          senderId: userId!.uid,
          receiverId: receiverId,
          timeStamp: DateTime.now(),
          message: text,
        );

        context.read<ChatBloc>().add(SendMessages(message));
        messageController.clear();

        Future.delayed(const  Duration(milliseconds: 300), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent + 100,
            duration:const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    }

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
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatLoaded) {
            final messages = state.message;

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo/download.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                reverse: false,
                padding:const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == receiverId;

                  return Align(
                    alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.grey[300] : mainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(
                              color: isMe ? Colors.black : Colors.white,
                            ),
                          ),
                          Text(
                            DateFormat.Hm() .format(DateTime.parse(message.timeStamp.toString()))
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('No messages found'),
            );
          }
        },
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
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              kwidth,
              Container(
                height: 50,
                width: 50,
                decoration:const BoxDecoration(
                  color: textColor,
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send, color: mainColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}