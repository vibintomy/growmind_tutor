import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/conversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/student_profile.dart';

abstract class ChatRepositories {
  Stream<Either<Failure, List<Conversation>>> getTutorConversation(String tutorId);
  Stream<Either<Failure, List<Message>>> getMessage(
      String tutorId, String studentId);
  Future<Either<Failure, void>> sendMessageToStudent(
      String tutorId, String studentId, String message);
  Future<Either<Failure, StudentProfile>> getStudentProfile(String studentId);
}
