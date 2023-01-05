import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/ui/budget/add_budget_transaction.dart';
import 'package:moneyger/ui/widget/budget/transaction_budget_history_item.dart';
import 'package:moneyger/ui/widget/loading/loading_animation.dart';
import 'package:moneyger/ui/widget/transaction/transaction_history_item.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailBudgetPage extends StatefulWidget {
  final String docId;

  const DetailBudgetPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<DetailBudgetPage> createState() => _DetailBudgetPageState();
}

class _DetailBudgetPageState extends State<DetailBudgetPage> {
  String _docId = '';
  final _document = FirebaseFirestore.instance
      .collection('users')
      .doc(SharedCode().uid)
      .collection('budget');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _docId = widget.docId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _document.doc(_docId).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
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
                            children: [
                              Text(
                                data['category'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                data['desc'],
                                style: const TextStyle(fontSize: 12),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        SharedCode()
                                            .convertToIdr(data['budget'], 0),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorValue.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  CircularPercentIndicator(
                                    // size
                                    radius: 30.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: SharedCode().getPercentDouble(
                                        data['budget'], data['used']),
                                    center: Text(
                                      SharedCode().getPercentString(
                                          data['budget'], data['used']),
                                      style: const TextStyle(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sisa',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        SharedCode()
                                            .convertToIdr(data['remain'], 0),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorValue.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Terpakai',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        SharedCode()
                                            .convertToIdr(data['used'], 0),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorValue.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Riwayat Transaksi",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigate.navigatorPush(
                                  context,
                                  AddBudgetTransactionPage(
                                    docId: widget.docId,
                                  ));
                            },
                            child: const Text(
                              "+ Tambah Transaksi",
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorValue.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TransactionBudgetHistoryItem(docId: data.id),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: LoadingAnimation(),
                );
              }
            }),
      ),
    );
  }
}
