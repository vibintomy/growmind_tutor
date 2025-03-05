import 'package:growmind_tutuor/features/home/data/data_source/student_datasource.dart';
import 'package:growmind_tutuor/features/home/domain/entities/student_entities.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_student_repositories.dart';

class StudentRepoImpl implements FetchStudentRepositories {
  final StudentDatasource studentDatasourceImpl;
  StudentRepoImpl(this.studentDatasourceImpl);
  @override 
  Future<List<StudentEntities>> getStudent(String tutorId) async {
    return await studentDatasourceImpl.getStudent(tutorId);
  }
}
