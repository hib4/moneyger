import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  Map<String, dynamic> _income = {};
  Map<String, dynamic> _expenditure = {};
  bool _isLoaded = false;

  final List<String> _day = [
    'mon',
    'tue',
    'wed',
    'thu',
    'fri',
    'sat',
    'sun',
  ];

  Future _getDataIncome() async {
    var document = FirebaseFirestore.instance
        .collection('users')
        .doc(SharedCode().uid)
        .collection('income')
        .doc(SharedCode().formattedDate);

    var value = await document.get();
    _income = value.data() ?? {};
  }

  Future _getDataExpenditure() async {
    var document = FirebaseFirestore.instance
        .collection('users')
        .doc(SharedCode().uid)
        .collection('expenditure')
        .doc(SharedCode().formattedDate);

    var value = await document.get();
    _expenditure = value.data() ?? {};
  }

  Future _getData() async {
    await _getDataIncome();
    await _getDataExpenditure();
    setState(() {
      _isLoaded = true;
    });
  }

  List<FlSpot> _getChartTransaction(Map<String, dynamic> data) {
    List<FlSpot> listTransaction = [];
    if (data.isEmpty) {
      for (int i = 0; i < 7; i++) {
        listTransaction.add(FlSpot(i.toDouble(), 0));
      }
    } else {
      for (int i = 0; i < 7; i++) {
        if (data['day'][_day[i]] == null) {
          listTransaction.add(FlSpot(i.toDouble(), 0));
        } else {
          listTransaction.add(
            FlSpot(
              i.toDouble(),
              double.parse(data['day'][_day[i]].toString()),
            ),
          );
        }
      }
    }
    return listTransaction;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? LineChart(
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
                  spots: _getChartTransaction(_income),
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
                  spots: _getChartTransaction(_expenditure),
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
          )
        : AspectRatio(
      aspectRatio: 1.8,
            child: emptyLineChart(),
          );
  }

  LineChart emptyLineChart() {
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
