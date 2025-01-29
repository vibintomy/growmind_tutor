import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_state.dart';

class MonetizationPage extends StatelessWidget {
  const MonetizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final courseBloc = context.read<FetchCourseBloc>();
    courseBloc.add(FetchCourseEvent(tutorId: user!.uid));
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text(
          'Course List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Course',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            BlocBuilder<FetchCourseBloc, CourseState>(
                builder: (context, state) {
              if (state is CourseLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CourseLoaded) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses[index];
                        return ExpansionTile(
                          title: Text(course.id),
                          subtitle: Text(course.courseDescription),
                          leading: Image.network(
                            course.imageUrl,
                            width: 50,
                            height: 50,
                          ),
                          children: course.sections.map((section) {
                            return ListTile(
                              title: Text(section.sectionName),
                            );
                          }).toList(),
                        );
                      }),
                );
              } else if (state is CourseError) {
                return const Center(
                  child: Text('Error while Fetching data'),
                );
              }
              return const Center(
                child: Text('No Course is Available'),
              );
            })
          ],
        ),
      ),
    );
  }
}
