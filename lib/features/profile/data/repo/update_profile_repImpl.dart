import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/core/utils/cloudinary.dart';
import 'package:growmind_tutuor/features/profile/domain/repo/update_profile_repo.dart';

class UpdateProfileRepimpl extends UpdateProfileRepo {
  final Cloudinary cloudinary;
  final FirebaseFirestore firestore;
  UpdateProfileRepimpl(this.cloudinary, this.firestore);

  @override
  Future<String> uploadImage(File imagePath) async {
    final imageUrl = await cloudinary.uploadImage(imagePath);
    return imageUrl;
  }

  @override
  Future<void> updateProfile({required String id,required String name,required String phone,String? imageUrl}) async {
    try {
      String? imagePath;

      final updatedData = {
        'displayName': name,
        'phone': phone,
      if(imageUrl!=null) 'imageUrl':imageUrl
      };
      await firestore.collection('tutors').doc(id).update(updatedData);
    } catch (e) {
      throw Exception('Failed to update data');
    }
  }
}
