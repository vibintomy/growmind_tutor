import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/login_bloc/auth_event.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/login_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc({required FirebaseAuth firebasepath})
      : _firebaseAuth = firebasepath,
        super(AuthInitial()) {
    on<LoginRequested>(onLoginRequested);
    on<SignupRequested>(onSignupRequested);
  }

  Future<void> onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> onSignupRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
