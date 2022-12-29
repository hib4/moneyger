import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxX: 6,
        borderData: FlBorderData(
          border: Border.all(
            color: const Color(0XFFF0F0F0),
          ),
        ),
        gridData: FlGridData(
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0XFFF0F0F0),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0XFFF0F0F0),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: _getTitleData(),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 0),
              const FlSpot(1, 0),
              const FlSpot(2, 1300),
              const FlSpot(3, 10000),
              const FlSpot(5, 1100),
            ],
            isCurved: true,
            color: ColorValue.greenColor,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) {
                return FlDotCirclePainter(
                  strokeWidth: 0,
                  color: ColorValue.greenColor,
                );
              },
            ),
          ),
          LineChartBarData(
            spots: [
              const FlSpot(0, 0),
              const FlSpot(1, 0),
              const FlSpot(2, 1000),
              const FlSpot(3, 12000),
              const FlSpot(5, 10000),
            ],
            isCurved: true,
            color: ColorValue.redColor,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) {
                return FlDotCirclePainter(
                  strokeWidth: 0,
                  color: ColorValue.redColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData _getTitleData() {
    return FlTitlesData(
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 0:
                return const Text('Sen');
              case 1:
                return const Text('Sel');
              case 2:
                return const Text('Rab');
              case 3:
                return const Text('Kam');
              case 4:
                return const Text('Jum');
              case 5:
                return const Text('Sab');
              case 6:
                return const Text('Min');
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
