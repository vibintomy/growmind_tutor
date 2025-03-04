import 'package:equatable/equatable.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';

abstract class ChatEvent extends Equatable {
  ChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatEvent {
  final String tutorId;
  final String studentId;
  LoadMessages(this.tutorId, this.studentId);

  @override
  List<Object?> get props => [tutorId, studentId];
}

class SendMessages extends ChatEvent {
  final String message;
  final String tutorId;
  final String studentId;

  SendMessages({ required this.message,required  this.tutorId,required  this.studentId}  );
  @override
  List<Object?> get props => [message,tutorId,studentId];
}
class ChatErrorEvent extends ChatEvent {
  final Failure failure;
  ChatErrorEvent(this.failure);
}

class ChatLoadedEvent extends ChatEvent {
  final List<Message> message;
  ChatLoadedEvent(this.message);
}
