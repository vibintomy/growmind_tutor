import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growmind_tutuor/core/utils/cloudinary.dart';
import 'package:growmind_tutuor/features/home/domain/repository/upload_course_repo.dart';

class UploadCourseRepoImpl implements UploadDataRepo {
  final Cloudinary cloudinary;
  final FirebaseFirestore firestore;

  UploadCourseRepoImpl(this.cloudinary, this.firestore);
 @override
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
      final imageFile = File(imagePath);
      final imageUrl = await cloudinary.uploadImage(imageFile);
      List<Map<String, String>> updatedSections = [];
      for (var section in sections) {
        if (section['videoPath'] == null || section['videoPath']!.isEmpty) {
          throw Exception('Invalid video file path for section: ${section['sectionName']}');
        }

        final videoFile = File(section['videoPath']!);
        final videoUrl = await cloudinary.uploadVideo(videoFile);
        updatedSections.add({
          'sectionName': section['sectionName']!,
          'sectionDescription': section['sectionDescription']!,
          'videoUrl': videoUrl, 
        });
      }

    
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user logged in');
      }
      final courseDoc = await firestore.collection('courses').add({
        'courseName': courseName,
        'courseDescription': courseDescription,
        'category': category,
        'subCategory': subCategory,
        'coursePrice': coursePrice,
        'imageUrl': imageUrl,
        'createdBy': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
   

      for (var section in updatedSections) {
        await firestore
            .collection('courses')
            .doc(courseDoc.id)
            .collection('sections')
            .add({
          'sectionName': section['sectionName'],
          'sectionDescription': section['sectionDescription'],
          'videoUrl': section['videoUrl'],
          'createdAt': FieldValue.serverTimestamp(),
        });
     
      }
 
      await courseDoc.update({'id': courseDoc.id});    
    } catch (e) {
      throw Exception('Firestore error: $e');
    }
  }


  @override
  Future<void> uploadSection({
    required String courseId,
    required String sectionName,
    required String sectionDescription,
    required String vedioFilePath,
  }) async {
    try {
    
      final videoFile = File(vedioFilePath);
      final videoUrl = await cloudinary.uploadVideo(videoFile);
      await firestore
          .collection('courses')
          .doc(courseId)
          .collection('sections')
          .add({
        'sectionName': sectionName,
        'sectionDescription': sectionDescription,
        'videoUrl': videoUrl,
        'createdAt': FieldValue.serverTimestamp(),
      }); 
    } catch (e) {
      throw Exception('Error uploading section: $e');
    }
  }
}
