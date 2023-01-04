import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/widget/transaction/transaction_history_item.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailBudgetPage extends StatefulWidget {
  const DetailBudgetPage({Key? key}) : super(key: key);

  @override
  State<DetailBudgetPage> createState() => _DetailBudgetPageState();
}

class _DetailBudgetPageState extends State<DetailBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
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
                        'Januari 2023',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorValue.borderColor),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.only(bottom: 15),
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '1 Jan 2023 - 31 Jan 2023',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
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
                          const Spacer(),
                          CircularPercentIndicator(
                            // size
                            radius: 30.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.7,
                            center: const Text(
                              "100%",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: ColorValue.secondaryColor),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: ColorValue.secondaryColor,
                            backgroundColor: const Color(0xFFEDF0F4),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: ColorValue.borderColor,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Tersisa',
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
                                'Terpakai',
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
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Riwayat Transaksi",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "+Tambah Transaksi",
                    style: TextStyle(
                        fontSize: 12, color: ColorValue.secondaryColor),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const TransactionHistoryItem(),
            ],
          ),
        ),
      ),
    );
  }
}
