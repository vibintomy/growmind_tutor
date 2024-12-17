
import 'package:growmind_tutuor/features/profile/domain/entities/profile.dart';

abstract class ProfileRepo {
  Future<Profile> getProfile(String userId);
  Future<void> updateProfile(
      {required String userId,
      required String displayName,
      required String phone,
      required String? profileImage});
}
  