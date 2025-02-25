import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/student_profile.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_event.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final GetTutorConversations getTutorConversations;
  final GetStudentProfile getStudentProfile;

  StreamSubscription<Either<Failure, List<Conversation>>>? _conversationsSubscription;
  Map<String, StudentProfile> _studentProfiles = {};

  ConversationBloc({
    required this.getTutorConversations,
    required this.getStudentProfile,
  }) : super(ConversationInitial()) {
    on<LoadConversations>(_onLoadConversations);
  }

  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());

    await _conversationsSubscription?.cancel();
    _conversationsSubscription = getTutorConversations(event.tutorId).listen(
      (failureOrConversations) {
        failureOrConversations.fold(
          (failure) => emit(ConversationError(failure)),
          (conversations) async {
            // Fetch student profiles for new conversations
            for (var conversation in conversations) {
              if (!_studentProfiles.containsKey(conversation.studentId)) {
                final profileResult = await getStudentProfile(conversation.studentId);
                profileResult.fold(
                  (failure) {}, // Handle error silently
                  (profile) {
                    _studentProfiles[conversation.studentId] = profile;
                  },
                );
              }
            }
            emit(ConversationLoaded(
              conversations: conversations,
              studentProfiles: Map.from(_studentProfiles),
            ));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    return super.close();
  }
}
