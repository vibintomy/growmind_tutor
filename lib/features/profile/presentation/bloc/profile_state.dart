
import 'package:growmind_tutuor/features/profile/domain/entities/profile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  ProfileLoaded(this.profile);
}



class ProfileUpdates extends ProfileState{}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}