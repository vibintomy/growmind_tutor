import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class LoadConversations extends ConversationEvent {
  final String tutorId;

  const LoadConversations(this.tutorId);

  @override
  List<Object> get props => [tutorId];
}