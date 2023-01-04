import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/widget/budget/budget_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Anggaran Kamu",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              CircularPercentIndicator(
                // size
                radius: 100.0,
                lineWidth: 10.0,
                animation: true,
                percent: 0.7,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Rp. 2.000.000",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: ColorValue.secondaryColor),
                    ),
                    const Text(
                      "Tersisa dari Rp. 3.000.000",
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xFF586371)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "1 januari 2023 - 31 januari 2023",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                          color: Color(0xFF586371)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorValue.secondaryColor.withOpacity(0.2)),
                      child: const Text(
                        '10 hari lagi',
                        style: TextStyle(color: ColorValue.secondaryColor),
                      ),
                    )
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: ColorValue.secondaryColor,
                backgroundColor: const Color(0xFFEDF0F4),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 16),
              //   child: Text(
              //     'Anggaran Kamu',
              //     style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black),
              //   ),
              // ),
              // const Divider(
              //   color: ColorValue.borderColor,
              //   thickness: 1,
              // ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const BudgetCard();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
