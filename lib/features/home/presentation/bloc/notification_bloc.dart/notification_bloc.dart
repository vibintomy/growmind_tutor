import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/repository/notification_repositories.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/send_notifications_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/notification_bloc.dart/notification_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/notification_bloc.dart/notification_state.dart';


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final SendNotificationUsecases sendPushNotificationUseCase;
  final NotificationRepositories notificationRepository;
  StreamSubscription? _notificationSubscription;

  NotificationBloc(
    this.sendPushNotificationUseCase,
    this.notificationRepository,
  ) : super(NotificationInitial()) {
    on<InitializeNotifications>(_onInitializeNotifications);
    on<SubscribeToUserTopic>(_onSubscribeToUserTopic);
    on<SendNotification>(_onSendNotification);
    on<NotificationReceived>(_onNotificationReceived);
  }

  Future<void> _onInitializeNotifications(
    InitializeNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    try {
    
      _notificationSubscription?.cancel();
      _notificationSubscription = notificationRepository
          .onNotificationReceived()
          .listen((notification) {
        add(NotificationReceived(notification));
      });
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onSubscribeToUserTopic(
    SubscribeToUserTopic event,
    Emitter<NotificationState> emit,
  ) async {
    try {
  
      await notificationRepository.subscribeToTopic(event.userId);
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onSendNotification(
    SendNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationSending());
    try {
      await sendPushNotificationUseCase(event.notificationEntities);
      emit(NotificationSent());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  void _onNotificationReceived(
    NotificationReceived event,
    Emitter<NotificationState> emit,
  ) {
    emit(NotificationReceiving(event.notificationEntities));
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}
