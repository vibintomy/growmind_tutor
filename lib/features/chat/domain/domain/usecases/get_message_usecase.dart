import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';

class GetMessageUsecase {
  final ChatRepositories chatRepositories;
  GetMessageUsecase(this.chatRepositories);

  Stream<Either<Failure, List<Conversation>>> call(
      String tutorId) {
    return chatRepositories.getTutorConversation(tutorId);
  }
}
