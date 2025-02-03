abstract class CreateCourseEvent {}

class UploadCourseEvent extends CreateCourseEvent {
  final String courseName;
  final String courseDiscription;
  final String category;
  final String subCategory;
  final List<Map<String, String>> sections;
  final String coursePrice;
  final String imagePath;

  UploadCourseEvent({
    required this.courseName,
    required this.courseDiscription,
    required this.category,
    required this.subCategory,
    required this.sections,
    required this.coursePrice,
    required this.imagePath,
  });
}

class UpdateCourseEvent extends CreateCourseEvent {
  final String courseId;
  final String courseName;
  final String courseDescription;
  final String category;
  final String subCategory;
  final String coursePrice;
  final String? imagePath;
  final List<Map<String, String>>? sections;

  UpdateCourseEvent({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.category,
    required this.subCategory,
    required this.coursePrice,
    this.imagePath,
    this.sections,
  });
}

class DeleteCourseEvent extends CreateCourseEvent {
  final String courseId;
  DeleteCourseEvent({required this.courseId});
}

class DeleteSectionEvent extends CreateCourseEvent {
  final String courseId;
  final String sectionId;
  DeleteSectionEvent({required this.courseId, required this.sectionId});
}
