// profile_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/monetization_page.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/privacy_policy.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/settings_page.dart';
import 'package:growmind_tutuor/features/profile/presentation/widgets/alert_box.dart';
import 'package:growmind_tutuor/features/profile/presentation/widgets/profile_header.dart';
import 'package:growmind_tutuor/features/profile/presentation/widgets/profile_menu_item.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeProfile(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(27),
        child: AppBar(
          backgroundColor: mainColor,
          title: const Text(
            'Profile',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      backgroundColor: textColor,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return buildProfileContent(context, state);
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
              child: Text('Something went wrong. Please check later'),
            );
          }
        }
      ),
    );
  }

  Widget buildProfileContent(BuildContext context, ProfileLoaded state) {
    final profile = state.profile;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
            ProfileHeader(
              imageUrl: profile.imageUrl,
              displayName: profile.displayName ?? 'User',
              email: profile.email ?? '@gmail.com',
            ),
            
            kheight1,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(color: greyColor, height: 2),
            ),
            
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                 
                  ProfileMenuItem(
                    icon: const Icon(Icons.settings, color: Colors.grey),
                    title: 'Settings',
                    onTap: () => navigateToSettings(context),
                  ),
                  kheight2,
                  
                
                  ProfileMenuItem(
                    icon: const Icon(Icons.wallet, color: Color.fromARGB(255, 235, 211, 0)),
                    title: 'My course',
                    onTap: () => navigateToMyCourses(context),
                  ),
                  kheight2,
                  
               
                  ProfileMenuItem(
                    icon: const Icon(Icons.privacy_tip, color: Colors.blue),
                    title: 'Privacy Policy',
                    onTap: () => navigateToPrivacyPolicy(context),
                  ),
                  kheight2,
                  
                  // Logout option
                  alertBox(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void initializeProfile(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No User found');
    }
    context.read<ProfileBloc>().add(LoadProfileEvent(user.uid));
  }

  Future<void> navigateToSettings(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
    
  
    final user = FirebaseAuth.instance.currentUser;
    context.read<ProfileBloc>().add(LoadProfileEvent(user!.uid));
  }

  void navigateToMyCourses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  MonetizationPage()),
    );
    

  }

  void navigateToPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
    );
  }
}