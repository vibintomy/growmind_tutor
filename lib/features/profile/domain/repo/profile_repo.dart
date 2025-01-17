
import 'package:growmind_tutuor/features/profile/domain/entities/profile.dart';

abstract class ProfileRepo {
  Future<Profile> getProfile(String userId);

}
  