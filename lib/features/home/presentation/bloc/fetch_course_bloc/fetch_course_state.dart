import 'package:growmind_tutuor/features/home/domain/entities/fetch_course_model.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseEntity> courses;
  CourseLoaded(this.courses);
}

class CourseError extends CourseState {
  final String Error;
  CourseError(this.Error);
}
