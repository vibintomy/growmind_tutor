
import 'package:growmind_tutuor/features/home/domain/entities/notification_entities.dart';

abstract class NotificationEvent {}

class InitializeNotifications extends NotificationEvent {}

class SubscribeToUserTopic extends NotificationEvent {
  final String userId;
  SubscribeToUserTopic(this.userId);
}

class SendNotification extends NotificationEvent {
  final NotificationEntities notificationEntities;
  SendNotification(this.notificationEntities);
}

class NotificationReceived extends NotificationEvent {
  final NotificationEntities notificationEntities;
  NotificationReceived(this.notificationEntities);
}
