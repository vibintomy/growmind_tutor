import 'package:growmind_tutuor/features/home/domain/entities/fetch_course_model.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_course_repo.dart';

  class FetchCourseUsecases {
    final FetchCourseRepo courseRepo;
    FetchCourseUsecases(this.courseRepo);

    Future<List<CourseEntity>> call(String tutorId) async {
      return courseRepo.fetchCourse(tutorId);
    }
  }
