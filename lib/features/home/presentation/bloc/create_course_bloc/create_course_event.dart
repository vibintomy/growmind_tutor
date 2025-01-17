abstract class CreateCourseEvent {}

class UploadVedioImageEvent extends CreateCourseEvent {
  final String VedioFilePath;
  final String ImagePath;
  UploadVedioImageEvent(this.VedioFilePath, this.ImagePath);
}

class UploadCourseEvent extends CreateCourseEvent {
  final String courseName;
  final String courseDiscription;
  final String category;
  final String subCategory;
   final List<Map<String, String>> sections;
  final String coursePrice;
  final String imagePath;
  UploadCourseEvent(
      {required this.courseName,
      required this.courseDiscription,
      required this.category,
      required this.subCategory,
      required this.sections,
      required this.coursePrice,
      required this.imagePath});
}
