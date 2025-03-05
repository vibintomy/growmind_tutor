import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/student_bloc/student_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/student_bloc/student_state.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/sync_fusion_chart.dart';

class StudentManagement extends StatelessWidget {
  const StudentManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorId = FirebaseAuth.instance.currentUser;
    final tutor = tutorId!.uid;
    context.read<StudentBloc>().add(GetStudentEvent(tutor));

    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text('Student Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Recently joined',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: mainColor)),
            kheight,
            BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
              if (state is StudentStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is StudentStateLoaded) {
               
                List<ChartData> chartData = _generateChartData(state);

                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: state.student.length,
                        itemBuilder: (context, index) {
                          final students = state.student[index];
                          return Card(
                            child: ListTile(
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipOval(
                                  child: Image.network(
                                    students.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                students.displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                'Joined at ${state.timeStamp.hour}:${state.timeStamp.minute}:${state.timeStamp.second}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    kheight,
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Color.fromARGB(255, 236, 229, 229),
                    ),
                    kheight1,
                    const Text(
                      'Weekly joins',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: mainColor),
                    ),
                    SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: SyncfusionBarChart(chartData: chartData),
                    ),
                  ],
                );
              } else if (state is StudentStateError) {
                return const Center(
                  child: Text('Error in adding values'),
                );
              } else {
                return const Center(
                  child: Text('Error in fetching values '),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  List<ChartData> _generateChartData(StudentStateLoaded state) {
   
    Map<int, int> weeklyCounts = {};

    DateTime now = DateTime.now();
    for (var student in state.student) {
      int dayDiff = now.difference(state.timeStamp).inDays;
      if (dayDiff < 7) {
        weeklyCounts[dayDiff] = (weeklyCounts[dayDiff] ?? 0) + 1;
      }
    }

   
    return List.generate(7, (index) {
      return ChartData(index, (weeklyCounts[index] ?? 0).toDouble());
    });
  }
}
