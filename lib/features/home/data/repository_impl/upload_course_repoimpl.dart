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
          throw Exception(
              'Invalid video file path for section: ${section['sectionName']}');
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
        final sectionvalues = await firestore
            .collection('courses')
            .doc(courseDoc.id)
            .collection('sections')
            .add({
          'sectionName': section['sectionName'],
          'sectionDescription': section['sectionDescription'],
          'videoUrl': section['videoUrl'],
          'createdAt': FieldValue.serverTimestamp(),
        });
        await sectionvalues.update({'id': sectionvalues.id});
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

  @override
  Future<void> updateCourse({
    required String courseId,
    required String courseName,
    required String courseDescription,
    required String category,
    required String subCategory,
    required String coursePrice,
    String? imagePath,
    List<Map<String, String>>? sections,
  }) async {
    try {
      String? imageUrl;

      // Upload Image if provided
      if (imagePath != null && imagePath.isNotEmpty) {
        final imageFile = File(imagePath);
        if (await imageFile.exists()) {
          imageUrl = await cloudinary.uploadImage(imageFile);
        } else {
          throw Exception("Image file does not exist at $imagePath");
        }
      }

      // Prepare course update data
      Map<String, dynamic> updatedData = {
        'courseName': courseName,
        'courseDescription': courseDescription,
        'category': category,
        'subCategory': subCategory,
        'coursePrice': coursePrice,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (imageUrl != null) {
        updatedData['imageUrl'] = imageUrl;
      }

      // Update course document
      await firestore.collection('courses').doc(courseId).update(updatedData);

      if (sections != null) {
        for (var section in sections) {
          String? videoUrl;
          if (section['videoPath'] != null &&
              section['videoPath']!.isNotEmpty) {
            final videoFile = File(section['videoPath']!);

            if (await videoFile.exists()) {
              videoUrl = await cloudinary.uploadVideo(videoFile);
            } else {
              throw Exception(
                  "Video file does not exist at ${section['videoPath']}");
            }
          }

          // If section has an ID, update existing section
          if (section.containsKey('id')) {
            await firestore
                .collection('courses')
                .doc(courseId)
                .collection('sections')
                .doc(section['id'])
                .update({
              'sectionName': section['sectionName'],
              'sectionDescription': section['sectionDescription'],
              'videoUrl': videoUrl ?? section['videoUrl'],
              'updatedAt': FieldValue.serverTimestamp(),
            });
          } else {
            // Otherwise, create a new section
            final newSection = await firestore
                .collection('courses')
                .doc(courseId)
                .collection('sections')
                .add({
              'sectionName': section['sectionName'],
              'sectionDescription': section['sectionDescription'],
              'videoUrl': videoUrl ?? '',
              'createdAt': FieldValue.serverTimestamp(),
            });

            await newSection.update({'id': newSection.id});
          }
        }
      }
    } catch (e) {
      throw Exception('Error updating course: $e');
    }
  }

  @override
  Future<void> deleteCourse({required String courseId}) async {
    try {
      var sectionSnapshot = await firestore
          .collection('courses')
          .doc(courseId)
          .collection('sections')
          .get();
      for (var section in sectionSnapshot.docs) {
        await section.reference.delete();
      }
      await firestore.collection('courses').doc(courseId).delete();
    } catch (e) {
      throw Exception('Unable delete the course $e');
    }
  }

  @override
  Future<void> deleteSection(
      {required String courseId, required String sectionId}) async {
    try {
      firestore
          .collection('courses')
          .doc(courseId)
          .collection('sections')
          .doc(sectionId)
          .delete();
    } catch (e) {
      throw Exception('Unable to delete the section');
    }
  }
}
