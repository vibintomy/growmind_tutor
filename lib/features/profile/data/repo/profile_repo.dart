
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
        throw Exception('Profile not found for userId: $userId');
      }

    
      return Profile(
        uid: profileModel.id,
          displayName: profileModel.displayName,
          email: profileModel.email,
          phone: profileModel.phone,
          imageUrl: profileModel.imageUrl,
          );
    } catch (e) {
      print('Error getting profile: $e');
      throw Exception('Failed to get profile: $e');
    }
  }
}
