import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';

class HomeController {
  /// Get current user ID from Firebase Auth
  static String getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? "";
  }
  
  /// Load user profile data through BLoC
  static void loadUserProfile(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    final userId = getUserId();
    profileBloc.add(LoadProfileEvent(userId));
  }
  
  /// Navigate to a given page
  static void navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}