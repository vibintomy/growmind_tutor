import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';

class GetTutorconversation {
  final ChatRepositories chatRepositories;
  GetTutorconversation(this.chatRepositories);

  Stream<Either<Failure, List<Conversation>>> call(String tutorId) {
    return chatRepositories.getTutorConversation(tutorId);
  }
}
