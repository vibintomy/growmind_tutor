import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/course_analytics.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/monetization_page.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/create_course/creation_page.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profilebloc = context.read<ProfileBloc>();
    profilebloc.add(LoadProfileEvent(user!.uid ?? ""));
    return Scaffold(
      backgroundColor: textColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state is ProfileLoaded) {
                        final profile = state.profile;
                        return Text(
                          'Hi,${profile.displayName.toUpperCase()}👋',
                          style: const TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        );
                      }
                      return const Text('');
                    }),
                    Container(
                        height: 50,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 45,
                                width: 95,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.notifications_outlined)),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const Text(
                  'What would like to teach Today?\nAdd Below.',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 112, 110, 110)),
                ),
                kheight1,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseAnalytics()));
                  },
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
                        ]),
                    child: Center(
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.show_chart,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        title: const Text(
                          'Course Analytics',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('View Statistics Relation'),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: mainColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                kheight1,
                Container(
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
                      ]),
                  child: Center(
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainColor,
                            ),
                            child: const Icon(
                              Icons.assignment,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      title: const Text(
                        'Student Mangement',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('View Student List'),
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: mainColor,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                kheight1,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MonetizationPage()));
                  },
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
                        ]),
                    child: Center(
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: secondaryColor,
                              ),
                              child: const Icon(
                                Icons.monetization_on,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        title: const Text(
                          'Monetization Option',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Set Price & Other Details '),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: mainColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                kheight1,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreationPage()));
                  },
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
                        ]),
                    child: Center(
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 249, 156, 110),
                              ),
                              child: const Icon(
                                Icons.video_library,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        title: const Text(
                          'Create Course',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Create Your New Course'),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: mainColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                kheight1,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
