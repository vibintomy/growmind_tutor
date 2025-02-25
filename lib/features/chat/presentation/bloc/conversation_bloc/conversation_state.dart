import 'package:equatable/equatable.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/student_profile.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Conversation> conversations;
  final Map<String, StudentProfile> studentProfiles;

  const ConversationLoaded({
    required this.conversations,
    required this.studentProfiles,
  });

  @override
  List<Object> get props => [conversations, studentProfiles];
}

class ConversationError extends ConversationState {
  final Failure failure;

  const ConversationError(this.failure);

  @override
  List<Object> get props => [failure];
}