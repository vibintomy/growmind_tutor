import 'package:firebase_auth/firebase_auth.dart';
import 'package:growmind_tutuor/features/auth/data/models/user_model.dart';


abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password, String displayName,String phone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? firebaseuser = userCredential.user;
      if (firebaseuser != null) {
        return UserModel(
            id: firebaseuser.uid,
            email: firebaseuser.email ?? '',
            displayName: firebaseuser.displayName ?? '',
            phone: firebaseuser.phoneNumber??'');
      } else {
        throw Exception('Failed to retrieve user details');
      }
    } catch (e) {
      throw Exception("Login failed:${e.toString()}");
    }
  }

  @override
  Future<UserModel> signup(
      String email, String password, String displayName,String phone) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(displayName);
        return UserModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            displayName: firebaseUser.displayName ?? '',
            phone: firebaseUser.phoneNumber??'');
      } else {
        throw Exception('Failed to retrieve user details afrer signUp');
      }
    } catch (e) {
      throw Exception('signUp failed ${e.toString()}');
    }
  }
}


