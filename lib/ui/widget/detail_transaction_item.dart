import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';

class DetailTransactionItem extends StatefulWidget {
  final bool isIncome;

  const DetailTransactionItem({Key? key, this.isIncome = true})
      : super(key: key);

  @override
  State<DetailTransactionItem> createState() => _DetailTransactionItemState();
}

class _DetailTransactionItemState extends State<DetailTransactionItem> {
  final _document =
      FirebaseFirestore.instance.collection('users').doc(SharedCode().uid);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _document.snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color:
                  widget.isIncome ? ColorValue.greenColor : ColorValue.redColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isIncome ? 'Pendapatan' : 'Pengeluaran',
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 88,
                      child: Text(
                        widget.isIncome
                            ? SharedCode().convertToIdr(data['income'], 0)
                            : SharedCode().convertToIdr(data['expenditure'], 0),
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                SvgPicture.asset(
                  widget.isIncome ? 'assets/svg/up.svg' : 'assets/svg/down.svg',
                ),
              ],
            ),
          );
        } else {

          // ganti dengan shimmer effect
          return Container(
            width: 150,
            height: 65,
            color: Colors.grey,
          );
        }
      },
    );
  }
}
