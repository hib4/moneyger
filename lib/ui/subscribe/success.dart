import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/bottom_navigation/bottom_navigation.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pembelian Paket Premium Moneyger Berhasil!',
                style: textTheme.headline2!.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Lottie.asset(
                'assets/lottie/success.json',
                width: size.width * 0.45,
                repeat: false,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigate.navigatorPushAndRemove(context, const BottomNavigation());
                },
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}