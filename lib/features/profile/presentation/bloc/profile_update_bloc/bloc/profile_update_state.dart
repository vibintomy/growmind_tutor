abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileImageUpdate extends ProfileUpdateState {
  final String imageUrl;
  ProfileImageUpdate(this.imageUrl);
}

class ProfileUpdated extends ProfileUpdateState {}

class ProfileError extends ProfileUpdateState {
  final String error;
  ProfileError(this.error);
}
