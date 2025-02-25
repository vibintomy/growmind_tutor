import 'package:dartz/dartz.dart';
import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/student_profile.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';

class GetStudentProfile {
  final ChatRepositories chatRepositories;
  GetStudentProfile(this.chatRepositories);

  Future<Either<Failure, StudentProfile>> call(String studentid) {
    return chatRepositories.getStudentProfile(studentid);
  }
}
