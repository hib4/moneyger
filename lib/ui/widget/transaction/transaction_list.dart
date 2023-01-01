import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/color_value.dart';

class WidgetTransactionList extends StatelessWidget {
  const WidgetTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 65,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(7.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 35,
            height: 35,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorValue.greenColor,
            ),
            child: SvgPicture.asset(
              'assets/svg/down.svg',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "json",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                "gaji dari jualan",
                style: TextStyle(fontSize: 10, color: ColorValue.greyColor),
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "+ Rp 1.000.000",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorValue.greenColor),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "gaji dari jualan",
                style: TextStyle(fontSize: 10, color: ColorValue.greyColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
