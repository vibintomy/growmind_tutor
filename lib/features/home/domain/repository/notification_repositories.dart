

import 'package:growmind_tutuor/features/home/domain/entities/notification_entities.dart';

abstract class NotificationRepositories {
  Future<void> sendPushNotification(NotificationEntities notification);
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Future<String> getDeviceToken();
  Stream<NotificationEntities> onNotificationReceived();
}
