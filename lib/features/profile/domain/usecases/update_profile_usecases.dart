import 'dart:io';

import 'package:growmind_tutuor/features/profile/domain/repo/update_profile_repo.dart';

class UpdateProfileUsecases {
  final UpdateProfileRepo updateProfileRepo;
  UpdateProfileUsecases(this.updateProfileRepo);

  Future<String> uploadImage(File imagePath) async {
    return await updateProfileRepo.uploadImage(imagePath);
  }

  Future<void> call({required String id,required String name,required String phone ,String? imageUrl}) async {
    await updateProfileRepo.updateProfile(id: id,name: name,phone: phone,imageUrl: imageUrl.toString());
  }
}
