import 'package:growmind_tutuor/features/auth/domain/entities/auth_user.dart';

abstract class GoogleAuthState {}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthLoaded extends GoogleAuthState {
  final GoogleAuthUser googleAuthUser;
  GoogleAuthLoaded(this.googleAuthUser);
}

class GoogleAuthError extends GoogleAuthState {
  final String error;
  GoogleAuthError(this.error);
}


class UnAuthenticated extends GoogleAuthState{}