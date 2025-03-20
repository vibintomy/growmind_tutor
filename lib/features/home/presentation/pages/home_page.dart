import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/course_analytics.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/monetization_page.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/student_management.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/create_course/creation_page.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/home_controller.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController.loadUserProfile(context);   
    return Scaffold(
      backgroundColor: textColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildUserGreeting(),
                const Text(
                  'What would like to teach Today?\nAdd Below.',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 112, 110, 110),
                  ),
                ),
                kheight1,
                buildMenuOption(
                  context: context,
                  title: 'Course Analytics',
                  subtitle: 'View Statistics Relation',
                  icon: Icons.show_chart,
                  iconColor: Colors.green,
                  destination: const CourseAnalytics(),
                ),
                kheight1,
                buildMenuOption(
                  context: context,
                  title: 'Student Management',
                  subtitle: 'View Student List',
                  icon: Icons.assignment,
                  iconColor: mainColor,
                  destination: const StudentManagement(),
                ),
                kheight1,
                buildMenuOption(
                  context: context,
                  title: 'Monetization Option',
                  subtitle: 'Set Price & Other Details',
                  icon: Icons.monetization_on,
                  iconColor: secondaryColor,
                  destination: const MonetizationPage(),
                ),
                kheight1,
                buildMenuOption(
                  context: context,
                  title: 'Create Course',
                  subtitle: 'Create Your New Course',
                  icon: Icons.video_library,
                  iconColor: const Color.fromARGB(255, 249, 156, 110),
                  destination: CreationPage(),
                ),
                kheight1,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserGreeting() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.profile;
          return Text(
            'Hi,${profile.displayName.toUpperCase()}👋',
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return const Text('');
      },
    );
  }

  Widget buildMenuOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      ),
      child: Container(
        height: 100,
        width: 400,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: textColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey,
              blurRadius: 5,
            )
          ],
        ),
        child: Center(
          child: ListTile(
            leading: Stack(
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor,
                  ),
                  child: Icon(
                    icon,
                    color: textColor,
                  ),
                ),
              ],
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(subtitle),
            trailing: const Icon(
              Icons.arrow_forward,
              color: mainColor,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}