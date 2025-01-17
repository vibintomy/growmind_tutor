import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';
import 'package:growmind_tutuor/features/profile/presentation/widgets/alert_box.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(LoadProfileEvent(user!.uid??''));
    if (user == null) {
      print('No user currently logged in');
    }

    return Scaffold(
      backgroundColor: textColor,
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 250,
                            width: 150,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                          ),
                          Container(
                            height: 170,
                            width: 135,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      profile.displayName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    kheight,
                    Text(
                      profile.email,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    kheight1,
                    Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.person),
                            kwidth,
                            Text(
                              'Edit Profile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.wallet),
                            kwidth,
                            Text(
                              'My course',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.notifications),
                            kwidth,
                            Text(
                              'Notifications',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.security),
                            kwidth,
                            Text(
                              'Terms & conditions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.help_center),
                            kwidth,
                            Text(
                              'Help Center',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        kheight2,
                        alertBox(context),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('something went wrong. please check later'),
          );
        }
      }),
    );
  }
}
