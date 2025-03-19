import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class LineChartGraphWidget extends StatelessWidget {
  final List<dynamic> courses;

  const LineChartGraphWidget({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final chartData = _processChartData();

    if (chartData.isEmpty) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.blue[700]!.withOpacity(.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No sales data available',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Total input courses: ${courses.length}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue[700]!.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  return Text('\$${value.toStringAsFixed(0)}', style: style);
                },
                reservedSize: 35,
                interval: _getYAxisInterval(chartData),
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  
        
                  if (value >= 0 && value < chartData.length) {
                    return Text(
                      '${chartData[value.toInt()].day}\n${chartData[value.toInt()].dateString}', 
                      style: style,
                      textAlign: TextAlign.center,
                    );
                  }
                  return const Text('', style: TextStyle(fontSize: 0));
                },
                reservedSize: 50,
                interval: 1,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (chartData.length - 1).toDouble(),
          minY: 0,
          maxY: _getMaxYValue(chartData),
          lineBarsData: [
            LineChartBarData(
              spots: chartData.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value.totalValue);
              }).toList(),
              isCurved: true,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              color: Colors.pink,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.pink.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DailySalesData> _processChartData() {
  
    if (courses == null || courses.isEmpty) {
      return [];
    }

  
    final latestDate = courses.map((course) {
      try {
        return DateTime.parse(course.createdAt?.toString() ?? '');
      } catch (e) {
        return null;
      }
    }).where((date) => date != null).toList();

    if (latestDate.isEmpty) {
      return [];
    }

    final mostRecentDate = latestDate.reduce((a, b) => a!.isAfter(b!) ? a : b);
    final sevenDaysAgo = mostRecentDate!.subtract(const Duration(days: 6));
    
    final Map<DateTime, DailySalesData> dailyData = {};

    for (var course in courses) {
      DateTime? date;
      try {
        date = DateTime.tryParse(course.createdAt?.toString() ?? '');
        
        if (date == null) continue;
      } catch (e) {
        continue;
      }

      if (date.isBefore(sevenDaysAgo)) continue;

      final coursePrice = double.tryParse(course.coursePrice?.toString() ?? '0') ?? 0;
      final purchaseCount = int.tryParse(course.purchaseCount?.toString() ?? '0') ?? 0;

      final totalValue = coursePrice * purchaseCount;

      final dateKey = DateTime(date.year, date.month, date.day);
      
      if (dailyData.containsKey(dateKey)) {
        dailyData[dateKey]!.totalValue += totalValue;
        dailyData[dateKey]!.courseCount += purchaseCount;
      } else {
        dailyData[dateKey] = DailySalesData(
          date: dateKey,
          day: DateFormat('EEE').format(dateKey),
          dateString: DateFormat('MM/dd').format(dateKey),
          totalValue: totalValue,
          courseCount: purchaseCount,
        );
      }
    }

  
    return dailyData.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  double _getMaxYValue(List<DailySalesData> data) {
    if (data.isEmpty) return 50;
    final maxValue = data.map((e) => e.totalValue).reduce((a, b) => a > b ? a : b);
     return maxValue <= 0 ? 50 : maxValue * 1.2;
  }

  double _getYAxisInterval(List<DailySalesData> data) {
    if (data.isEmpty) return 10;
    final maxValue = _getMaxYValue(data);
    return maxValue <= 0 ? 10 : maxValue / 5;
  }
}

class DailySalesData {
  DateTime date;
  String day;
  String dateString;
  double totalValue;
  int courseCount;

  DailySalesData({
    required this.date,
    required this.day,
    required this.dateString,
    required this.totalValue,
    required this.courseCount,
  });
}