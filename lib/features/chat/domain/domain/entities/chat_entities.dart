

class Message  {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timeStamp;

 const Message(
      {required this.senderId,
      required this.receiverId,
      required this.message,
      required this.timeStamp});

}
