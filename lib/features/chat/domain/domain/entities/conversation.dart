class Conversation {
  final String chatRoomId;
  final String studentId;
  final String lastMessage;
  final int lastMessageTime;

  Conversation({
    required this.chatRoomId,
    required this.studentId,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}