import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphView extends StatelessWidget {
  final List<double> npuData;
  final List<double> lightData;

  const GraphView({
    Key? key,
    required this.npuData,
    required this.lightData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (npuData.isEmpty && lightData.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            "کوئی ڈیٹا موجود نہیں",
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: _maxLength().toDouble(),
            minY: 0,
            maxY: 1,
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              _buildLine(
                data: npuData,
                color: Colors.blue,
              ),
              _buildLine(
                data: lightData.map((e) => e / 100).toList(),
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartBarData _buildLine({
    required List<double> data,
    required Color color,
  }) {
    return LineChartBarData(
      spots: data.asMap().entries.map(
        (e) => FlSpot(e.key.toDouble(), e.value),
      ).toList(),
      isCurved: true,
      colors: [color],
      barWidth: 2,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  int _maxLength() {
    return [
      npuData.length,
      lightData.length,
    ].reduce((a, b) => a > b ? a : b);
  }
}
