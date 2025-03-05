import 'package:growmind_tutuor/features/home/domain/entities/student_entities.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_student_repositories.dart';

class FetchStudentUsecases {
  final FetchStudentRepositories fetchStudentRepositories;
  FetchStudentUsecases(this.fetchStudentRepositories);
  Future<List<StudentEntities>> call(String tutorId) {
    return fetchStudentRepositories.getStudent(tutorId);
  }
}
