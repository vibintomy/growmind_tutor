import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String displayName;
  final String email;
  final String password;
  final String phone;

const  SignupSubmitted(
      {required this.displayName,
      required this.email,
      required this.password,
      required this.phone});

  @override
  List<Object> get props => [displayName, email, password, phone];
}
