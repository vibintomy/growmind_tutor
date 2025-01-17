abstract class CreateCourseState {}

class CreateCourseInitial extends CreateCourseState {}

class CreateCourseLoading extends CreateCourseState {}

class UploadVideoImageSuccess extends CreateCourseState {
  final Map<String, String> mediaUrls;

  UploadVideoImageSuccess({required this.mediaUrls});
}

class UploadVideoImageFailure extends CreateCourseState {
  final String errorMessage;

  UploadVideoImageFailure({required this.errorMessage});
}

class UploadCourseSuccess extends CreateCourseState {}

class UploadCourseFailure extends CreateCourseState {
  final String errorMessage;

  UploadCourseFailure({required this.errorMessage});
}
