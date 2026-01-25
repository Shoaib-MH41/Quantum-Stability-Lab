import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphView extends StatelessWidget {
  final List<double> npuData;
  final List<double> lightData;
  
  const GraphView({
    required this.npuData,
    required this.lightData,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // NPU وقت کا گراف
            LineChartBarData(
              spots: npuData.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value);
              }).toList(),
              isCurved: true,
              color: Colors.blue,
              dotData: FlDotData(show: false),
            ),
            // روشنی کا گراف
            LineChartBarData(
              spots: lightData.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value / 100);
              }).toList(),
              isCurved: true,
              color: Colors.orange,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
