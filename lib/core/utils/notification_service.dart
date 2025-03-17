import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:growmind_tutuor/features/home/data/model/notification_model.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;
  final StreamController<NotificationModel> notificationStreamController;
  NotificationService(
      this.flutterLocalNotificationsPlugin, this.firebaseMessaging)
      : notificationStreamController =
            StreamController<NotificationModel>.broadcast();
  Stream<NotificationModel> get notificationStream =>
      notificationStreamController.stream;

  Future<void> initialize() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User grant permission : ${settings.authorizationStatus}');

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosinitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosinitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('message data ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification${message.notification}');
        showLocalNotification(message);
        notificationStreamController
            .add(convertMessageToNotificationModel(message));
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('Initial message ${message.data}');
        notificationStreamController
            .add(convertMessageToNotificationModel(message));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('message opened app: ${message.data}');
      notificationStreamController
          .add(convertMessageToNotificationModel(message));
    });
  }

  NotificationModel convertMessageToNotificationModel(RemoteMessage message) {
    return NotificationModel(
        id: message.messageId ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        senderId: message.data['senderId'] ?? '',
        receiverId: message.data['receiverId'] ?? '',
        timeStamp: message.data['timestamp'] != null
            ? DateTime.parse(message.data['timestamp'])
            : DateTime.now(),
        data: message.data);
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id',
              'channel_name',
              channelDescription: 'channel_description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              icon: android.smallIcon,
            ),
            iOS: const DarwinNotificationDetails()),
        payload: jsonEncode(message.data),
      );
    }
  }

  void onSelectNotification(NotificationResponse response) {
    if (response.payload != null) {
      try {
        Map<String, dynamic> data = jsonDecode(response.payload!);
        notificationStreamController.add(NotificationModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: '',
            body: '',
            senderId: data['senderId'] ?? '',
            receiverId: data['receiverId'] ?? '',
            timeStamp: data['timeStamp'] != null
                ? DateTime.parse(data['timeStamp'])
                : DateTime.now(),
            data: data));
      } catch (e) {
        print('Error in passing notificationPayload');
      }
    }
  }

  Future<String> getDeviceToken() async {
    
    return await firebaseMessaging.getToken() ?? '';
    
  }

  void dispose() {
    notificationStreamController.close();
  }
}
