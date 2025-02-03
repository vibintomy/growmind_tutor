abstract class CreateCourseState {}

class CreateCourseInitial extends CreateCourseState {}

class CreateCourseLoading extends CreateCourseState {}

class UploadCourseSuccess extends CreateCourseState {}

class UploadCourseFailure extends CreateCourseState {
  final String errorMessage;

  UploadCourseFailure({required this.errorMessage});
}

class UpdateCourseSuccess extends CreateCourseState {}

class UpdateCourseFailure extends CreateCourseState {
  final String errorMessage;

  UpdateCourseFailure({required this.errorMessage});
}

class DeletCourseSucess extends CreateCourseState {
  final String courseId;
  DeletCourseSucess({required this.courseId});
}

class DeleteSectionSucess extends CreateCourseState {
  final String sectionId;
  DeleteSectionSucess({required this.sectionId});
}

class DeleteCourseFailure extends CreateCourseState {
  final String error;
  DeleteCourseFailure(this.error);
}
