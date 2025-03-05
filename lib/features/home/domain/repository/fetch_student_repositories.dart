import 'package:growmind_tutuor/features/home/domain/entities/student_entities.dart';

abstract class FetchStudentRepositories {
  Future<List<StudentEntities>> getStudent(String tutorId);
}
