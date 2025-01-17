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
  Future<Map<String, String>> uploadVedioImage(String vedioPath, String imagePath) async {
    try {
      final videoFile = File(vedioPath);
      final imageFile = File(imagePath);
      

      // Upload video and image to Cloudinary
      final videoUrl = await cloudinary.uploadVideo(videoFile);
      final imageUrl = await cloudinary.uploadImage(imageFile);
  
      // Return URLs as a map
      return {'videoUrl': videoUrl, 'imageUrl': imageUrl};
    } catch (e) {
      throw Exception('Cloudinary upload error: $e');
    }
  }

  @override
  Future<void> uploadCourse({
    required String courseName,
    required String courseDiscription,
    required String category,
    required String subCategory,
    required List<Map<String, String>> sections, // Supports multiple sections
    required String coursePrice,
    required String imagePath,
  }) async {
    try {
      // Upload course image
      final imageFile = File(imagePath);
      final imageUrl = await cloudinary.uploadImage(imageFile);

      // Ensure user is logged in
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user logged in');
      }

      // Add course details to Firestore
      final courseDoc = await firestore.collection('courses').add({
        'courseName': courseName,
        'courseDescription': courseDiscription,
        'category': category,
        'subCategory': subCategory,
        'coursePrice': coursePrice,
        'imageUrl': imageUrl,
        'createdBy': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Upload all sections associated with the course
      for (var section in sections) {
        if (section['sectionName'] == null ||
            section['sectionDescription'] == null ||
            section['vedioFilePath'] == null) {
          throw Exception('Invalid section data provided');
        }
        await uploadSection(
          courseId: courseDoc.id, // Pass the course ID
          sectionName: section['sectionName']!,
          sectionDescription: section['sectionDescription']!,
          vedioFilePath: section['vedioFilePath']!,
        );
      }

      // Update the course document with its ID
      await courseDoc.update({'id': courseDoc.id});
    } catch (e) {
      throw Exception('Firestore error: $e');
    }
  }

  @override
  Future<void> uploadSection({
    required String courseId, // Pass course ID explicitly
    required String sectionName,
    required String sectionDescription,
    required String vedioFilePath,
  }) async {
    try {
      // Upload section video to Cloudinary
      final videoFile = File(vedioFilePath);
      final videoUrl = await cloudinary.uploadVideo(videoFile);

      // Add section details to Firestore
      final sectionsCollection = firestore
          .collection('courses')
          .doc(courseId) // Use the correct course ID
          .collection('sections');

      await sectionsCollection.add({
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
