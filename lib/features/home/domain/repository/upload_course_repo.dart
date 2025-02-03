abstract class UploadDataRepo {
  Future<void> uploadCourse({
    required String courseName,
    required String courseDescription,
    required String category,
    required String subCategory,
    required List<Map<String, String>> sections,
    required String coursePrice,
    required String imagePath,
  });

  Future<void> uploadSection({
    required String courseId,
    required String sectionName,
    required String sectionDescription,
    required String vedioFilePath,
  });

  Future<void> updateCourse({
    required String courseId,
    required String courseName,
    required String courseDescription,
    required String category,
    required String subCategory,
    required String coursePrice,
    String? imagePath,
    List<Map<String, String>>? sections,
  });
  Future<void> deleteCourse({required String courseId});
  Future<void> deleteSection(
      {required String courseId, required String sectionId});
}
