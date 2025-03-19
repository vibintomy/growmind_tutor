import 'package:growmind_tutuor/features/auth/domain/entities/auth_user.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/google_auth_repositories.dart';

class GoogleAuthUsecases {
  final GoogleAuthRepositories googleAuthRepositories;
  GoogleAuthUsecases(this.googleAuthRepositories);
  Future<GoogleAuthUser?> call() {
    return googleAuthRepositories.signInWithGoogle();
  }

  Future<void> callSignOUt() {
    return googleAuthRepositories.signOut();
  }
}
