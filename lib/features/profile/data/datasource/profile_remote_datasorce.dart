import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:growmind_tutuor/features/profile/data/model/profile_model.dart';

class ProfileRemoteDatasource {
  final FirebaseFirestore firestore;

  ProfileRemoteDatasource(this.firestore);

  Future<ProfileModel> fetchProfile(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('tutors').doc(userId).get();

      if (snapshot.exists && snapshot.data() != null) {
        return ProfileModel.fromFirestore(snapshot.data()!);
      } else {
        throw Exception('profile data does not exists for userId $userId');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<void> updateProfile(
      {required String userId,
      required String displayName,
      required String phone,
      String? profileImage}) async {
    final Map<String, dynamic> data = {
      'displayName': displayName,
      'phone': phone
    };
    if (profileImage != null) {
      data['profileImage'] = profileImage;
      
    }
    await firestore.collection('tutors').doc(userId).update(data);
  }
}
