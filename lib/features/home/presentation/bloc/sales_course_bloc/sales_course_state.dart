import 'package:growmind_tutuor/core/error/failures.dart';
import 'package:growmind_tutuor/features/home/domain/entities/saled_course.dart';

abstract class SalesCourseState {}

class SalesCourseInitial extends SalesCourseState {}

class SalesCourseLoading extends SalesCourseState {}

class SalesCourseLoaded extends SalesCourseState {
  final List<SaledCourse> courses;
  SalesCourseLoaded({required this.courses});
}

class SalesCourseError extends SalesCourseState {
  final String  message;
  SalesCourseError(this.message);
}
