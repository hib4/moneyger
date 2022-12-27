import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/color_value.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FlSpot> dummyData1 = List.generate(7, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  final List<FlSpot> dummyData2 = List.generate(7, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang, User',
                style: textTheme.headline2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Pendapatan dan Pengeluaran kamu bulan ini',
                style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                decoration: BoxDecoration(
                  color: const Color(0XFFF9F9F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Saldo',
                            style: textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Rp. 3.000.000',
                            style: textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AspectRatio(
                      aspectRatio: 1.8,
                      child: LineChart(
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
                              spots: dummyData1,
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
                              spots: dummyData2,
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _detailTransaction(textTheme),
                  _detailTransaction(textTheme, isIncome: false),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/article.svg',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Artikel',
                        style: textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Artikel mengenai keuanganmu',
                        style: textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Color(0XFFD7D7D7),
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Segala lorem ipsum dolor sit amet kala lorem ipsum dolor sit amet kala',
                            style: textTheme.headline4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Edukasi',
                            style: textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          reservedSize: 30,
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

  Widget _detailTransaction(TextTheme textTheme, {bool isIncome = true}) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isIncome ? ColorValue.greenColor : ColorValue.redColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isIncome ? 'Pendapatan' : 'Pengeluaran',
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                isIncome ? 'Rp. 14.000.000' : 'Rp. 13.000.000',
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          SvgPicture.asset(
            isIncome ? 'assets/svg/up.svg' : 'assets/svg/down.svg',
          )
        ],
      ),
    );
  }
}
