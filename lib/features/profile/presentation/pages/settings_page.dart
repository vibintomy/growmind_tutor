import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/help_center.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/security_page.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/terms_and_conditons.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/update_page.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settingsOptions = [
      {
        'title': 'Edit Profile',
        'icon': Icons.person,
        'color': Colors.blueAccent,
        'onTap': () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => UpdatePage()));
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // ignore: use_build_context_synchronously
            context.read<ProfileBloc>().add(LoadProfileEvent(user.uid));
          }
        },
      },
      {
        'title': 'Terms & Conditions',
        'icon': Icons.security,
        'color': Colors.green,
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TermsAndConditionsPage()));
        },
      },
      {
        'title': 'Help Center',
        'icon': Icons.help_center,
        'color': Colors.purple,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HelpCenter()));
        },
      },
      {
        'title': 'Security',
        'icon': Icons.security,
        'color': Colors.red,
        'onTap': () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>const SecurityPage()));
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: textColor),
        ),
        iconTheme:const IconThemeData(color: textColor),
        centerTitle: true,
      ),
      backgroundColor: textColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             kheight2,
              Expanded(
                child: GridView.builder(
                  itemCount: settingsOptions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final item = settingsOptions[index];
                    return GestureDetector(
                      onTap: item['onTap'],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], size: 40, color: item['color']),
                            const SizedBox(height: 10),
                            Text(
                              item['title'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
