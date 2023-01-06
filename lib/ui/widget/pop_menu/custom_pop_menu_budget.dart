import 'package:flutter/material.dart';
import 'package:moneyger/service/firebase_service.dart';

class CustomPopMenuBudget extends PopupMenuEntry<int> {
  final List data;

  const CustomPopMenuBudget({super.key, required this.data});

  @override
  final double height = 100;

  @override
  bool represents(int? value) => value == 1 || value == -1;

  @override
  PlusMinusEntryState createState() => PlusMinusEntryState();
}

class PlusMinusEntryState extends State<CustomPopMenuBudget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _buildPopupDialog(context),
        ).then(
          (value) => Navigator.pop(context),
        );
      },
      borderRadius: BorderRadius.circular(4),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            'Delete',
            style: textTheme.bodyText1!.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      title: const Text('Peringatan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Apakah anda yakin ingin menghapus ${widget.data[5]}?'),
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
            var data = widget.data;
            await FirebaseService()
                .deleteBudgetTransaction(
                  context,
                  docId: data[0],
                  docIdTransaction: data[1],
                  total: data[2],
                  day: data[3],
                  week: data[4],
                )
                .then(
                  (value) => value ? Navigator.pop(context) : null,
                );
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  }
}
