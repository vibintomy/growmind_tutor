import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/profile/domain/repo/profile_repo.dart';
import 'package:growmind_tutuor/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final ProfileRepo profileRepo;
  ProfileBloc(this.getProfile, this.profileRepo) : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());

      try {
        final profile = await getProfile(event.userId);
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError('Failed to load profile : $e'));
      }
    });
    
  }

   Future<void> onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await profileRepo.updateProfile(
          userId: event.userId,
          displayName: event.displayName,
          phone: event.phone,
          profileImage: event.profileImage);
      final updateProfile = await getProfile(event.userId);
      emit(ProfileLoaded(updateProfile));
    } catch (e) {
      emit(ProfileError('Failed to update profile : $e'));
    }
  }   
}
