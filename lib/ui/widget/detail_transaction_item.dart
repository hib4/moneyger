import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyger/common/color_value.dart';

class DetailTransactionItem extends StatefulWidget {
  final bool isIncome;

  const DetailTransactionItem({Key? key, this.isIncome = true})
      : super(key: key);

  @override
  State<DetailTransactionItem> createState() => _DetailTransactionItemState();
}

class _DetailTransactionItemState extends State<DetailTransactionItem> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: widget.isIncome ? ColorValue.greenColor : ColorValue.redColor,
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
                widget.isIncome ? 'Pendapatan' : 'Pengeluaran',
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.isIncome ? 'Rp. 14.000.000' : 'Rp. 13.000.000',
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
            widget.isIncome ? 'assets/svg/up.svg' : 'assets/svg/down.svg',
          ),
        ],
      ),
    );
  }
}
