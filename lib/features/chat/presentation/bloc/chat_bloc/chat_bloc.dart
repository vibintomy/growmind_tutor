import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_message_students.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_send_message.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetSendMessage sendMessage;
  final GetMessageStudents getMessageWithStudents;
  StreamSubscription<Either<Failure, List<Message>>>? messageSubscription;
  
  ChatBloc({required this.getMessageWithStudents, required this.sendMessage})
      : super(ChatInitial()) {
    on<LoadMessages>(onLoadMessages);
    on<SendMessages>(onSendMessage);
    on<ChatLoadedEvent>(
        (event, emit) => emit(ChatLoaded(message: event.message)));
    on<ChatErrorEvent>((event, emit) => emit(ChatError(event.failure)));
  }
  
  Future<void> onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    await messageSubscription?.cancel();
    messageSubscription = getMessageWithStudents(event.tutorId, event.studentId)
        .listen((failureOrMessage) {
      failureOrMessage.fold(
        (failure) => add(ChatErrorEvent(failure)),
        (message) => add(ChatLoadedEvent(message)),
      );
    });
  }
  
  Future<void> onSendMessage(
    SendMessages event,
    Emitter<ChatState> emit,
  ) async {
    // Don't emit MessageSending() as it breaks UI flow
    final result =
        await sendMessage(event.tutorId, event.studentId, event.message);
    result.fold(
        (failure) => emit(ChatError(failure)),
        (_) {
          // Do nothing here instead of emitting MessageSent()
          // The stream subscription will automatically update with new messages
        });
  }
  
  @override
  Future<void> close() async {
    await messageSubscription?.cancel();
    return super.close();
  }
}