
import 'package:growmind_tutuor/features/home/domain/entities/notification_entities.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSending extends NotificationState {}

class NotificationSent extends NotificationState {}

class NotificationReceiving extends NotificationState {
  final NotificationEntities notificationEntities;
  NotificationReceiving(this.notificationEntities);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}

