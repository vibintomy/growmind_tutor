import 'package:growmind_tutuor/features/home/domain/entities/fetch_course_model.dart';

abstract class FetchCourseRepo {
  Future<List<CourseEntity>> fetchCourse(String tutorId);
}
