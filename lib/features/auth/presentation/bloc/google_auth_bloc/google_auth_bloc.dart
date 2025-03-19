import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/auth/domain/usecases/google_auth_usecases.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/google_auth_bloc/google_auth_event.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/google_auth_bloc/google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final GoogleAuthUsecases googleAuthRepositories;
  GoogleAuthBloc(this.googleAuthRepositories) : super(GoogleAuthInitial()) {
    on<GoogleSignInEvent>(onSignInWithGoogle);
  }

  Future<void> onSignInWithGoogle(
      GoogleSignInEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoading());
    try {
      final user = await googleAuthRepositories.call();
      if (user != null) {
        emit(GoogleAuthLoaded(user));
      } else {
        emit(GoogleAuthError('signInFailed'));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }

  Future<void> onSignOut(
      SignOutEvent event, Emitter<GoogleAuthState> emit) async {
    await googleAuthRepositories.callSignOUt();
    emit(UnAuthenticated());
  }
}
