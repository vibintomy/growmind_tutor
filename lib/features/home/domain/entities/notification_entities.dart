class NotificationEntities {
  final String id;
  final String title;
  final String body;
  final String senderId;
  final String receiverId;
  final DateTime timeStamp;
  final Map<String, dynamic> data;

  NotificationEntities(
      {required this.id,
      required this.body,
      required this.title,
      required this.receiverId,
      required this.data,
      required this.senderId,
      required this.timeStamp,});
}
