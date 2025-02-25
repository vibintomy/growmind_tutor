import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';

class GetMessageStudents {
  final ChatRepositories chatRepositories;
  GetMessageStudents(this.chatRepositories);

  Stream<Either<Failure, List<Message>>> call(
      String tuturId, String studentId) {
    return chatRepositories.getMessage(tuturId, studentId);
  }
}
