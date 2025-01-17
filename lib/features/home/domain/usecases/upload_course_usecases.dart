import 'package:growmind_tutuor/features/home/domain/repository/upload_course_repo.dart';

class UploadCourseUsecases {
  final UploadDataRepo uploadDataRepo;

  UploadCourseUsecases(this.uploadDataRepo);

  /// Upload video and image
  Future<Map<String, String>> uploadVedioImage({
    required String vedioPath,
    required String imagePath,
  }) async {
    try {
      return await uploadDataRepo.uploadVedioImage(vedioPath, imagePath);
    } catch (e) {
      throw Exception('Error uploading video and image: $e');
    }
  }

  /// Upload a single section
  Future<void> uploadSection({
    required String courseId,
    required String sectionName,
    required String sectionDescription,
    required String vedioFilePath,
  }) async {
    try {
      
      await uploadDataRepo.uploadSection(
        courseId: courseId,
        sectionName: sectionName,
        sectionDescription: sectionDescription,
        vedioFilePath: vedioFilePath,
      );
    } catch (e) {
      throw Exception('Error uploading section: $e');
    }
  }

  /// Upload the entire course with its details
  Future<void> uploadCourse({
    required String courseName,
    required String courseDiscription,
    required String category,
    required String subCategory,
    required List<Map<String, String>> sections, // List of section data
    required String coursePrice,
    required String imagePath,
  }) async {
    
    try {
      // Ensure all sections have the required fields
      for (var section in sections) {
        if (section['sectionName'] == null ||
            section['sectionDescription'] == null ||
            section['vedioFilePath'] == null) {
          throw Exception('Invalid section data: Missing required fields');
        }
      }

      // Upload course details first to get the course ID
      await uploadDataRepo.uploadCourse(
        courseName: courseName,
        courseDiscription: courseDiscription,
        category: category,
        subCategory: subCategory,
        sections: sections, // Pass the entire sections list
        coursePrice: coursePrice,
        imagePath: imagePath,
      );
    } catch (e) {
      throw Exception('Error uploading course: $e');
    }
  }
}
