import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/line_chart_graph_widget.dart';

class CourseAnalytics extends StatelessWidget {
  const CourseAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
      ),
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child:const LineChartGraphWidget() ,
        )
      ],
    ),
  ),

    );
  }
}
