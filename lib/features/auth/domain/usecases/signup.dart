import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:growmind_tutuor/features/auth/domain/entities/user.dart';
import '../repositories/auth_repositoreis.dart';


class Signup {
  final AuthRepository repository;
  Signup(this.repository);

  Future<User> execute(
      String email, String password, String displayName, String phone,String) async {
    try {
      final user = await repository.signup(email, password, displayName, phone);

      final firebaseUser = FirebaseAuth.instance.currentUser;
      await firebaseUser?.reload();
   

      if (firebaseUser != null && !firebaseUser.emailVerified) {
        await firebaseUser.sendEmailVerification();
        print('Verification email sent to ${firebaseUser.email}.');
      }

      return user;
    } catch (e) {
      print('Error during signup: $e');
      throw Exception('Signup failed: $e');
    }
  }
}
