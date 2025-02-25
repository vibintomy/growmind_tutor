import 'package:equatable/equatable.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';

abstract class ChatState extends Equatable {
  ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> message;
  ChatLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageSending extends ChatState {}

class MessageSent extends ChatState {}

class ChatError extends ChatState {
  final Failure failure;
  ChatError(this.failure);
}
