import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/budget/add_budget_transaction.dart';
import 'package:moneyger/ui/budget/edit_budget.dart';
import 'package:moneyger/ui/widget/budget/transaction_budget_history_item.dart';
import 'package:moneyger/ui/widget/loading/loading_animation.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';
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
        title: const Text(
          'Detail Anggaran',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _document.doc(_docId).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                if (!snapshot.data!.exists) {
                  return const Center(
                    child: LoadingAnimation(),
                  );
                }

                var data = snapshot.data!;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Row(
                            children: [
                              IconButton(
                                splashRadius: 30,
                                onPressed: () {
                                  Navigate.navigatorPush(
                                    context,
                                    EditBudgetPage(
                                      docId: _docId,
                                      budget: data['budget'],
                                      category: data['category'],
                                      desc: data['desc'],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit_rounded,
                                  size: 22,
                                ),
                              ),
                              IconButton(
                                splashRadius: 30,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => _buildPopupDialog(
                                      context,
                                      data['desc'],
                                      data.id,
                                      data['used'],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.redAccent,
                                  size: 22,
                                ),
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
                                    category: data['category'],
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
                      TransactionBudgetHistoryItem(
                        docId: data.id,
                        category: data['category'],
                      ),
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

  Widget _buildPopupDialog(
      BuildContext context, String desc, String docId, num used) {
    return AlertDialog(
      elevation: 0,
      title: const Text('Peringatan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Apakah anda yakin ingin menghapus $desc?'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Kembali'),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseService()
                .deleteBudget(context, docId: docId, used: used)
                .then(
                  (value) => value
                      ? Navigator.popUntil(context, (route) => route.isFirst)
                      : showSnackBar(context,
                          title: 'Gagal menghapus anggaran'),
                );
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  }
}
