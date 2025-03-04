import 'package:growmind_tutuor/features/home/domain/entities/saled_course.dart';

abstract class SaledCourseRepostory {
  Future<List<SaledCourse>> getCourse(String tutorId);
}
