import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncfusionBarChart extends StatelessWidget {
  final List<ChartData> chartData;
  const SyncfusionBarChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: SfCartesianChart(
        borderWidth: 0,
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: NumericAxis(
          title: AxisTitle(text: "Days"),
          interval: 1, 
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: "Students Joined"),
        ),
        series: <CartesianSeries<ChartData, int>>[
          ColumnSeries<ChartData, int>(
            dataSource: chartData,
            color: Colors.teal,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
