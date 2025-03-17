
import 'package:growmind_tutuor/features/home/domain/entities/notification_entities.dart';
import 'package:growmind_tutuor/features/home/domain/repository/notification_repositories.dart';

class SendNotificationUsecases {
  final NotificationRepositories notificationRepositories;
  SendNotificationUsecases(this.notificationRepositories);

  Future<void> call(NotificationEntities notification) {
    return notificationRepositories.sendPushNotification(notification);
  }
}
