

import 'package:growmind_tutuor/features/home/domain/entities/notification_entities.dart';

class NotificationModel extends NotificationEntities {
  NotificationModel(
      {required String id,
      required String title,
      required String body,
      required String senderId,
      required String receiverId,
      required DateTime timeStamp,
      required Map<String, dynamic> data})
      : super(
            id: id,
            title: title,
            body: body,
            senderId: senderId,
            receiverId: receiverId,
            timeStamp: timeStamp,
            data: data);

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        senderId: json['senderId'] ?? '',
        receiverId: json['receiverId'] ?? '',
        timeStamp: json['timeStamp'] != null
            ? DateTime.parse(json['timeStamp'])
            : DateTime.now(),
        data: json['data'] ?? {});
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'senderId': senderId,
      'receiverId': receiverId,
      'timeStamp': timeStamp,
      'data': data
    };
  }
}
