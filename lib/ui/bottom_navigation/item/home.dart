import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/main.dart';
import 'package:moneyger/service/api_service.dart';
import 'package:moneyger/ui/budget/add_budget.dart';
import 'package:moneyger/ui/chat/chat.dart';
import 'package:moneyger/ui/transaction/add_transaction.dart';
import 'package:moneyger/ui/widget/artikel/artikel_card.dart';
import 'package:moneyger/ui/widget/chart/chart_widget.dart';
import 'package:moneyger/ui/widget/detail_transaction_item.dart';
import 'package:moneyger/ui/widget/headline_item.dart';
import 'package:moneyger/ui/widget/transaction/transaction_history_item.dart';
import 'package:moneyger/ui/widget/user_item/user_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _artikel = [];
  final ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);

  Future _getArtikel() async {
    await ApiService().getservice().then((value) {
      setState(() {
        _artikel = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getArtikel();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add_rounded,
          activeIcon: Icons.close_rounded,
          backgroundColor: ColorValue.secondaryColor,
          renderOverlay: true,
          overlayColor: Colors.white,
          overlayOpacity: 0.5,
          childrenButtonSize: const Size(60, 60),
          spacing: 5,
          spaceBetweenChildren: 5,
          openCloseDial: isDialOpen,
          children: [
            SpeedDialChild(
              child: SvgPicture.asset(
                'assets/icons/transaction.svg',
                color: Colors.white,
                width: 18,
                height: 18,
              ),
              backgroundColor: ColorValue.secondaryColor,
              foregroundColor: Colors.white,
              label: 'Transaksi',
              labelStyle: const TextStyle(color: Colors.black),
              onTap: () =>
                  Navigate.navigatorPush(context, const AddTransactionPage()),
            ),
            SpeedDialChild(
              child: SvgPicture.asset(
                'assets/icons/budget.svg',
                color: Colors.white,
                width: 18,
                height: 18,
              ),
              backgroundColor: ColorValue.secondaryColor,
              foregroundColor: Colors.white,
              label: 'Anggaran',
              labelStyle: const TextStyle(color: Colors.black),
              onTap: () =>
                  Navigate.navigatorPush(context, const AddBudgetPage()),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeNameItem(),
                  Text(
                    'Pendapatan dan Pengeluaran kamu bulan ini',
                    style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: const Color(0XFFF9F9F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Saldo',
                                style: textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TotalBalanceItem(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const AspectRatio(
                          aspectRatio: 1.8,
                          child: ChartWidget(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      DetailTransactionItem(),
                      DetailTransactionItem(isIncome: false),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const HeadlineItem(
                    image: 'transaction',
                    title: 'Transaksi',
                    desc: 'Beberapa transaksi kamu akhir-akhir ini',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const TransactionHistoryItem(
                    isHome: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const HeadlineItem(
                    image: 'info',
                    title: 'Konsultasi Keuangan',
                    desc: 'Konsultasikan keuanganmu!',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 136,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: ColorValue.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/konsultasi.png'),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ingin Konsultasi?',
                                style: textTheme.headline3!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Bingung dengan Keuangan kamu sekarang? Konsultasi aja!',
                                style: textTheme.bodyText2!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  minimumSize: const Size(74, 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ChatPage(),
                                      )).whenComplete(() => Future.delayed(
                                          const Duration(milliseconds: 250))
                                      .then((value) => statusBarStyle()));
                                },
                                child: Text(
                                  'Konsultasi',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: ColorValue.secondaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const HeadlineItem(
                    image: 'article',
                    title: 'Artikel',
                    desc: 'Artikel mengenai ekonomi',
                  ),
                  _artikel.isEmpty
                      ? Container()
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ArtikelCard(
                              judul: _artikel[index].judul,
                              subjudul: _artikel[index].subjudul,
                              tanggalPosting: _artikel[index].tanggalPosting,
                              penulis: _artikel[index].penulis,
                              foto: _artikel[index].foto,
                              isiArtikel: _artikel[index].isiArtikel,
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
