import 'dart:io';


abstract class UpdateProfileRepo {
  Future<String> uploadImage(File imagePath);
  Future<void> updateProfile({required String id,required String name,required String phone,String imageUrl });
}
