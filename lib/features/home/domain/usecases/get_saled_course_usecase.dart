import 'package:growmind_tutuor/features/home/domain/entities/saled_course.dart';
import 'package:growmind_tutuor/features/home/domain/repository/saled_course_repostory.dart';

class GetSaledCourseUsecase {
  final SaledCourseRepostory saledCourseRepostory;
  GetSaledCourseUsecase(this.saledCourseRepostory);
  Future<List<SaledCourse>> call(String tutorId) {
 
    return saledCourseRepostory.getCourse(tutorId);
  }
}
