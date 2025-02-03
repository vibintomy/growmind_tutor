import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_state.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/update_course.dart';


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
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: textColor),
        title: const Text(
          'Course List',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: textColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'My Courses',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: mainColor),
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateCourse(course: course,)));
                          },
                          child: SizedBox(
                            height: 180,
                            child: Card(
                                color: textColor,
                                shadowColor: greyColor,
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 150,
                                        height: 160,
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 3),
                                                  spreadRadius: 0,
                                                  blurRadius: 3,
                                                  color: greyColor)
                                            ],
                                            shape: BoxShape.rectangle,
                                            color: greyColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1))),
                                        child: Image.network(
                                          course.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            kheight2,
                                            kwidth1,
                                            Text(
                                              course.subCategory,
                                              style: const TextStyle(
                                                  color: textColor1,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            kheight1,
                                            Text(
                                              course.courseName,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Price - ${course.coursePrice}-/',
                                              style: const TextStyle(
                                                  color: mainColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
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
