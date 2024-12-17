abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  final String userId;
  LoadProfileEvent(this.userId);
}

class UpdateProfileEvent extends ProfileEvent {
  final String userId;
  final String displayName;
  final String phone;
  final String? profileImage;
  UpdateProfileEvent(
      {required this.userId,
      required this.displayName,
      required this.phone,
      this.profileImage});
    
  List<Object?> get props => [userId, displayName, phone, profileImage];
}