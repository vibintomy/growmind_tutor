import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';

class GetSendMessage {
  final ChatRepositories chatRepositories;
  GetSendMessage(this.chatRepositories);

  Future<Either<Failure, void>> call(
      String tutorId, String studentId, String message) {
    return chatRepositories.sendMessageToStudent(tutorId, studentId, message);
  }
}
