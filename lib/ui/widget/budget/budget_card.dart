import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/detail_budget/detail_budget.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetCard extends StatefulWidget {
  const BudgetCard({Key? key}) : super(key: key);

  @override
  State<BudgetCard> createState() => _BudgetCardState();
}

class _BudgetCardState extends State<BudgetCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailBudgetPage(),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorValue.borderColor),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.only(bottom: 15),
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFF9F9F9),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Belanja',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '1 Jan 2023 - 26 Jan 2023',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
                ],
              ),
            ),
            const Divider(
              color: ColorValue.borderColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Anggaran',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Rp. 1.202.000',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorValue.secondaryColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Anggaran',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Rp. 1.202.000',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorValue.secondaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 63,
              animation: true,
              lineHeight: 15.0,
              animationDuration: 750,
              percent: 0.66,
              center: const Text(
                "66.0%",
                style: TextStyle(color: Colors.black),
              ),
              barRadius: const Radius.circular(16),
              progressColor: ColorValue.secondaryColor,
              backgroundColor: const Color(0xFFEDF0F4),
            ),
          ],
        ),
      ),
    );
  }
}
