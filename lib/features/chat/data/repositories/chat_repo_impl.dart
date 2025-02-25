import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/student_profile.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';

class ChatRepoImpl implements ChatRepositories {
  final ChatRemoteDatasource chatRemoteDatasource;
  ChatRepoImpl(this.chatRemoteDatasource);

  @override
  Stream<Either<Failure, List<Conversation>>> getTutorConversation(
      String tutorId)  {
    return chatRemoteDatasource
        .getConversation(tutorId)
        .map((conversation) => Right<Failure, List<Conversation>>(conversation))
        .handleError((error) {
      return Left<Failure, List<Conversation>>(ServerFailure(error));
    });
  }
   @override
  Stream<Either<Failure, List<Message>>> getMessage(String tutorId, String studentId) {
    return chatRemoteDatasource.getMessages(tutorId, studentId)
        .map((messages) => Right<Failure, List<Message>>(messages))
        .handleError((error) {
      return Left<Failure, List<Message>>(
        ServerFailure(error.toString()),
      );
    });
  }

@override
  Future<Either<Failure, void>> sendMessageToStudent(String tutorId, String studentId, String message) async {
    try {
      await chatRemoteDatasource.sendMessage(tutorId, studentId, message);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentProfile>> getStudentProfile(String studentId) async {
    try {
      final profile = await  chatRemoteDatasource.getStudentProfile(studentId);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
