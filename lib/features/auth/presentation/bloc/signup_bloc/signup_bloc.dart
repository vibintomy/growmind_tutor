
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/signup_bloc/signup_event.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/signup_bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  SignupBloc({required this.auth,required this.firestore}) : super(SignupInitial()) {
    on<SignupSubmitted>(onSignupSubmitted);
  }

  Future<void> onSignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      await firestore.collection('tutors').doc(userCredential.user!.uid).set({
        'displayName': event.displayName,
        'email': event.email,
        'phone': event.phone,
        'uid': userCredential.user!.uid,
        'created_at':FieldValue.serverTimestamp(),
      });
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
