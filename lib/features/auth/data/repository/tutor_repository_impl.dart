import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growmind_tutuor/core/utils/cloudinary.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/tutor_repositories.dart';

class TutorRepositoryImpl implements TutorRepositories {
  final Cloudinary cloudinary;
  final FirebaseFirestore firestore;
  TutorRepositoryImpl({required this.cloudinary, required this.firestore});

  @override
  Future<String> uploadPdf(String filePath) async {
    try {
      final pdfFile = File(filePath);
      final pdfUrl = await cloudinary.uploadPdf(pdfFile);
      return pdfUrl;
    } catch (e) {
      throw Exception('Cloudinary upload error $e');
    }
  }

  @override
  Future<void> submitKyc(
      {required String name,
      required String email,
      required String profession,
      required String filePath}) async {
    try {
      final pdfUrl = await uploadPdf(filePath);
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('Error in passing the data');
      }

      final kycValues = await firestore.collection('kyc').add({
        'name': name,
        'vemail': email,
        'pdfUrl': pdfUrl,
        'profession': profession,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp()
      });
      await kycValues.update({'id': kycValues.id});
    } catch (e) {
      throw Exception('Firestore error $e');
    }
  }
}
