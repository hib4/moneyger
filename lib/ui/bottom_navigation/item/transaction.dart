import 'package:flutter/material.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/transaction/add_transaction.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigate.navigatorPush(context, const AddTransactionPage());
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
