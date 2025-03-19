import 'package:growmind_tutuor/features/auth/domain/entities/auth_user.dart';

abstract class GoogleAuthRepositories {
  Future<GoogleAuthUser?> signInWithGoogle();
  Future<void> signOut();
}
