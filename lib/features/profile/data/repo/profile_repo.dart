
import 'package:growmind_tutuor/features/profile/data/datasource/profile_remote_datasorce.dart';
import 'package:growmind_tutuor/features/profile/domain/repo/profile_repo.dart';

import '../../domain/entities/profile.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDatasource remoteDatasource;
  ProfileRepoImpl(this.remoteDatasource);

  @override
  Future<Profile> getProfile(String userId) async {
    try {
      final profileModel = await remoteDatasource.fetchProfile(userId);

      if (profileModel == null) {
        print('Profile not found for userId: $userId');
        throw Exception('Profile not found for userId: $userId');
      }

      // Map ProfileModel to Profile
      return Profile(
          displayName: profileModel.displayName,
          email: profileModel.email,
          phone: profileModel.phone
          // Map other fields as necessary
          );
    } catch (e) {
      // Propagate the error up or handle accordingly
      print('Error getting profile: $e');
      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<void> updateProfile(
      {required String userId,
      required String displayName,
      required String phone,
      String? profileImage}) async {
    await remoteDatasource.updateProfile(
        userId: userId,
        displayName: displayName,
        phone: phone,
        profileImage: profileImage);
  }
}
