import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:growmind_tutuor/features/home/data/data_source/fcm_datasource.dart';
import 'package:growmind_tutuor/features/home/data/model/notification_model.dart';

import 'package:http/http.dart' as http;

class FCMDatasourceImpl implements FCMDatasource {
  final FirebaseMessaging firebaseMessaging;
  final http.Client httpClient;
  final StreamController<NotificationModel> notificationController;
  FCMDatasourceImpl(this.firebaseMessaging, this.httpClient)
      : notificationController =
            StreamController<NotificationModel>.broadcast();
  @override
  Future<String> getDeviceToken() async {
    return await firebaseMessaging.getToken() ?? '';
  }

  @override
  Stream<NotificationModel> onNotificationReceived() {
    return notificationController.stream;
  }

  @override
  Future<void> sendPushNotification(NotificationModel notification) async {
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    const String serverkey = '743881940512';

    final response = await httpClient.post(Uri.parse(fcmUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverkey',
        },
        body: jsonEncode({
          'to': '/topics/${notification.receiverId}',
          'notification': {
            'title': notification.title,
            'body': notification.body
          },
          'data': {
            ...notification.data,
            'senderId': notification.senderId,
            'receiverId': notification.receiverId,
            'timestamp': notification.timeStamp.toIso8601String(),
          }
        }));
    if (response.statusCode != 200) {
      throw Exception('Failed to send notification');
    }
  }

  @override
  Future<void> subscribeToTopic(String topic) {
    return firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeToTopic(String topic) {
    return firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
