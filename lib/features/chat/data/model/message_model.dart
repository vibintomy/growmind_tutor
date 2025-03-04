import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';

class MessageModel extends Message {
  final String? id;

  MessageModel({
    this.id,
    required String senderId,
    required String receiverId,
    required String message,
    required DateTime timeStamp,
  }) : super(
          senderId: senderId,
          receiverId: receiverId,
          message: message,
          timeStamp: timeStamp,
        );

  /// Convert Firestore JSON to Dart Model
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timeStamp: (json['timeStamp'] as Timestamp).toDate(), // Convert Timestamp to DateTime
    );
  }

  /// Convert Dart Model to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': Timestamp.fromDate(timeStamp), 
    };
  }
}
