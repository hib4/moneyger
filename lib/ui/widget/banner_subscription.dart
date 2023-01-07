import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/subscribe/subscribe.dart';

class BannerSubscription extends StatelessWidget {
  const BannerSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      color: ColorValue.primaryColor,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 170,
              child: Text(
                'Bareng Moneyger Premium, nikmati semua fitur tanpa batas',
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0XFFFFC973),
                minimumSize: const Size(74, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigate.navigatorPush(
                    context, const SubscribePage());
              },
              child: Text(
                'Langganan',
                style: textTheme.bodyText2!.copyWith(
                  color: ColorValue.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
