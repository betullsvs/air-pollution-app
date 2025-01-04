import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CityGraphic extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CityGraphic({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> coValues = [];
    data.sort((a, b) => a['hour'].compareTo(b['hour']));

    for (var i = 0; i < data.length; i++) {
      var hour = data[i]['hour'];
      var co = data[i]['co'];
      coValues.add(FlSpot(hour.toDouble(), co.toDouble()));
    }

    return Container(
      width: 800,
      height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  );
                },
                interval: 1,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          minX: 0,
          maxX: 23,
          minY: 0,
          maxY: 800,
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.green,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: coValues,
            ),
          ],
        ),
      ),
    );
  }
}
