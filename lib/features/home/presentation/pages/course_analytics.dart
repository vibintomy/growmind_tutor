import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_state.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/line_chart_graph_widget.dart';

class CourseAnalytics extends StatelessWidget {
  const CourseAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorId = FirebaseAuth.instance.currentUser;
    context
        .read<SalesCourseBloc>()
        .add(GetSalesCourseEvent(tutorId: tutorId!.uid));

    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        title: const Text('Course Analytics',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,
        backgroundColor: textColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Recent Sales',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: mainColor),
            ),
            BlocBuilder<SalesCourseBloc, SalesCourseState>(
              builder: (context, state) {
                if (state is SalesCourseLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SalesCourseLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: state.courses.length,
                          itemBuilder: (context, index) {
                            final course = state.courses[index];
                            final totalValue = (double.tryParse(course.coursePrice.toString()) ?? 0) *
                                (int.tryParse(course.purchaseCount.toString()) ?? 0);
                            return ListTile(
                              leading: SizedBox(
                                height: 30,
                                width: 30,
                                child: ClipOval(
                                  child: Image.network(
                                    course.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error, color: Colors.red);
                                    },
                                  ),
                                ),
                              ),
                              title: Text(course.courseName),
                              subtitle: Text(
                                DateTime.parse(course.createdAt).toLocal().toString(),
                              ),
                              trailing: Text(
                                '+ \$${totalValue.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: greyColor,
                        thickness: 1,
                      ),
                      kheight,
                       const Text(
              'Weekly Sales report',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: mainColor),
            ),
                      kheight,
                      SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: LineChartGraphWidget(courses: state.courses),
                      ),
                    ],
                  );
                } else if (state is SalesCourseError) {
                  return const Center(
                    child: Text('Failed to load values'),
                  );
                }
                return const Center(
                  child: Text('Failed to get the values'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}