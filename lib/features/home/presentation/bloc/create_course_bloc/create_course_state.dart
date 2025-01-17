abstract class CreateCourseState {}

class CreateCourseInitial extends CreateCourseState {}

class CreateCourseLoading extends CreateCourseState {}

class UploadCourseSuccess extends CreateCourseState {}

class UploadCourseFailure extends CreateCourseState {
  final String errorMessage;

  UploadCourseFailure({required this.errorMessage});
}
