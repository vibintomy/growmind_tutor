import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  ConversationModel({
    required String chatRoomId,
    required String studentId,
    required String lastMessage,
    required int lastMessageTime,
  }) : super(
          chatRoomId: chatRoomId,
          studentId: studentId,
          lastMessage: lastMessage,
          lastMessageTime: lastMessageTime,
        );

  factory ConversationModel.fromJson(Map<String, dynamic> json, String tutorId) {
    final participants = List<String>.from(json['participants'] ?? []);
    final studentId = participants.firstWhere(
      (id) => id != tutorId,
      orElse: () => '',
    );

    return ConversationModel(
      chatRoomId: json['chatRoomId'] ?? '',
      studentId: studentId,
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: (json['lastMessageTime'] is Timestamp)
      ?(json['lastMessageTime']as Timestamp).millisecondsSinceEpoch :(json['lastMessageTime']?? 0)
    );
  }
}