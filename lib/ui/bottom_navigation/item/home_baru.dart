import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/service/artikel_service.dart';
import 'package:moneyger/ui/transaction/add_transaction.dart';
import 'package:moneyger/ui/widget/artikel/artikel_card.dart';
import 'package:moneyger/ui/widget/chart/chart_widget.dart';
import 'package:moneyger/ui/widget/detail_transaction_item.dart';
import 'package:moneyger/ui/widget/transaction/transaction_list.dart';

class HomePageBaru extends StatefulWidget {
  const HomePageBaru({Key? key}) : super(key: key);

  @override
  State<HomePageBaru> createState() => _HomePageBaruState();
}

class _HomePageBaruState extends State<HomePageBaru> {
  List artikel = [];
  getArtikel() async {
    await ArtikelServiceClass().getservice().then((value) {
      setState(() {
        artikel = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getArtikel();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigate.navigatorPush(context, const AddTransactionPage());
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Biru
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 326,
                  width: MediaQuery.of(context).size.width,
                  color: ColorValue.secondaryColor,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 48),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                height: 35,
                                width: 35,
                                child: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/google.png'),
                                ),
                              ),
                              const Text(
                                "Selamat Pagi User",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const Text(
                          "IDR 3.000.000,00",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const Text(
                          "Total Saldo",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFC7C7C7)),
                        ),
                      ],
                    ),
                  ),
                ),

                // Chart
                Positioned(
                  // 326 = tinggi container biru, // 237 tinggi chart, dibagi 3 maksudnya sepertiga bagian chart yang ada di container biru
                  top: 326 - 237 / 3,
                  child: Container(
                    // Margin contents
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
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
                            child: Text(
                              'Pendapatan dan pengeluaranmu Bulan ini',
                              style: textTheme.bodyText2!.copyWith(),
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
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 236 / 3 * 2 + 24,
              // 236 = tinggi chart dibagi bagiannya 2/3 yang keluar dari container + 24 (margin top)
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      DetailTransactionItem(),
                      DetailTransactionItem(isIncome: false),
                    ],
                  ),
                  // Margin
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/article.svg',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaksi',
                            style: textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Transaksi kamu selama ini',
                            style: textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // List Transaksi baru baru ini
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const WidgetTransactionList();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Artikel
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/article.svg',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Artikel',
                            style: textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Artikel mengenai kuanganmu',
                            style: textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: artikel.length,
                    itemBuilder: (context, index) {
                      return ArtikelCard(
                          judul: artikel[index].judul,
                          subjudul: artikel[index].subjudul,
                          tanggalPosting: artikel[index].tanggalPosting,
                          penulis: artikel[index].penulis,
                          foto: artikel[index].foto,
                          isiArtikel: artikel[index].isiArtikel);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
