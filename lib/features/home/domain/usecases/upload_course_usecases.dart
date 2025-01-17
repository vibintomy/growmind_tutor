import 'package:growmind_tutuor/features/home/domain/repository/upload_course_repo.dart';

class UploadCourseUsecases {
  final UploadDataRepo uploadDataRepo;

  UploadCourseUsecases(this.uploadDataRepo);


  Future<void> uploadCourse({
    required String courseName,
    required String courseDescription,
    required String category,
    required String subCategory,
    required List<Map<String, String>> sections,
    required String coursePrice,
    required String imagePath,
  }) async {
    try {
    
for (var section in sections) {
  if (section['sectionName'] == null ||
      section['sectionDescription'] == null ||
      section['videoPath'] == null || 
      section['sectionName']!.isEmpty ||
      section['sectionDescription']!.isEmpty ||
      section['videoPath']!.isEmpty) {
    throw Exception('Invalid section data: Missing required fields in $section');
  }
}

   
      await uploadDataRepo.uploadCourse(
        courseName: courseName,
        courseDescription: courseDescription,
        category: category,
        subCategory: subCategory,
        sections: sections,
        coursePrice: coursePrice,
        imagePath: imagePath,
      );
    } catch (e) {
      throw Exception('Error uploading course: $e');
    }
  }
}
