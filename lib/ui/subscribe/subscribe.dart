import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/ui/subscribe/success.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';
import 'package:moneyger/ui/widget/subscribe/expansion.dart';
import 'package:moneyger/ui/widget/subscribe/subscribe_card.dart';
import 'package:provider/provider.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  int _selected = 0;
  ValueNotifier<bool> _isSuccess = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            provider.isDarkMode ? ColorValueDark.backgroundColor : Colors.white,
        title: Text(
          'Langganan',
          style: TextStyle(
              color: provider.isDarkMode ? Colors.white : Colors.black),
        ),
        leading: BackButton(
          color: provider.isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/logo2.svg',
                    width: 86.5,
                    height: 97.24,
                    color: provider.isDarkMode
                        ? ColorValueDark.secondaryColor
                        : ColorValue.secondaryColor,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    'Moneyger Premium',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: provider.isDarkMode
                            ? ColorValueDark.secondaryColor
                            : ColorValue.secondaryColor,
                        letterSpacing: 1.5),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text(
                    'Dengan fitur premium dari Moneyger, kamu bisa mendapatkan fitur-fitur lebih lengkap',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA3A3A3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 38,
                  ),

                  // Apa yg baru di premium content
                  const SubcribeCard(),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    'FAQ Tentang Moneyger Premium',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: provider.isDarkMode
                            ? ColorValueDark.secondaryColor
                            : ColorValue.secondaryColor),
                  ),
                  const Divider(
                    height: 16,
                    thickness: 1,
                    color: Color(0xFFDADADA),
                    endIndent: 70,
                    indent: 70,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const ExpansionWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pilih Paket',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: provider.isDarkMode
                              ? ColorValueDark.secondaryColor
                              : ColorValue.secondaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buttonbulanan(context),
                  const SizedBox(
                    height: 21,
                  ),
                  _buttontahunan(),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: _selected >= 1
                        ? () async {
                            await SharedCode().setToken('subs', 'true').then(
                                  (value) => value
                                      ? Navigate.navigatorPushAndRemove(
                                          context, const SuccessPage())
                                      : null,
                                );
                          }
                        : () {
                            showSnackBar(context,
                                title: 'Pilih paket terlebih dahulu');
                          },
                    child: const Text(
                      'Langganan Sekarang',
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isSuccess,
              builder: (_, value, __) => Visibility(
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonbulanan(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        if (_selected != 1) {
          setState(() {
            _selected = 1;
          });
        } else if (_selected == 1) {
          setState(() {
            _selected = 0;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(21, 17, 21, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _selected == 1
                ? provider.isDarkMode
                    ? ColorValueDark.secondaryColor
                    : ColorValue.secondaryColor
                : provider.isDarkMode
                    ? ColorValueDark.backgroundColor
                    : Colors.white,
            border: Border.all(
                color: provider.isDarkMode
                    ? ColorValueDark.secondaryColor
                    : ColorValue.secondaryColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                      color: _selected == 1
                          ? provider.isDarkMode
                              ? ColorValueDark.backgroundColor
                              : Colors.white
                          : provider.isDarkMode
                              ? ColorValueDark.secondaryColor
                              : ColorValue.secondaryColor)),
              child: Container(
                decoration: BoxDecoration(
                  color: provider.isDarkMode
                      ? ColorValueDark.backgroundColor
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bulanan',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _selected == 1
                          ? provider.isDarkMode
                              ? ColorValueDark.backgroundColor
                              : Colors.white
                          : provider.isDarkMode
                              ? ColorValueDark.secondaryColor
                              : ColorValue.secondaryColor),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    '30 Hari Trial & Bayar penuh satu bulan',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: _selected == 1
                            ? provider.isDarkMode
                                ? ColorValueDark.backgroundColor
                                : Colors.white
                            : provider.isDarkMode
                                ? ColorValueDark.secondaryColor
                                : ColorValue.secondaryColor),
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              'Rp. 20.000',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _selected == 1
                      ? provider.isDarkMode
                          ? ColorValueDark.backgroundColor
                          : Colors.white
                      : provider.isDarkMode
                          ? ColorValueDark.secondaryColor
                          : ColorValue.secondaryColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttontahunan() {
    final provider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        if (_selected != 2) {
          setState(() {
            _selected = 2;
          });
        } else if (_selected == 2) {
          setState(() {
            _selected = 0;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(21, 17, 21, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _selected == 2
                ? provider.isDarkMode
                    ? ColorValueDark.secondaryColor
                    : ColorValue.secondaryColor
                : provider.isDarkMode
                    ? ColorValueDark.backgroundColor
                    : Colors.white,
            border: Border.all(
                color: provider.isDarkMode
                    ? ColorValueDark.secondaryColor
                    : ColorValue.secondaryColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                      color: _selected == 2
                          ? provider.isDarkMode
                              ? ColorValueDark.backgroundColor
                              : Colors.white
                          : provider.isDarkMode
                              ? ColorValueDark.secondaryColor
                              : ColorValue.secondaryColor)),
              child: Container(
                decoration: BoxDecoration(
                  color: provider.isDarkMode
                      ? ColorValueDark.backgroundColor
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Tahunan',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _selected == 2
                              ? provider.isDarkMode
                                  ? ColorValueDark.backgroundColor
                                  : Colors.white
                              : provider.isDarkMode
                                  ? ColorValueDark.secondaryColor
                                  : ColorValue.secondaryColor),
                    ),
                    Text(
                      '/16.000 per bulan',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: _selected == 2
                              ? provider.isDarkMode
                                  ? ColorValueDark.backgroundColor
                                  : Colors.white
                              : provider.isDarkMode
                                  ? ColorValueDark.secondaryColor
                                  : ColorValue.secondaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    '30 Hari Trial & Bayar penuh satu tahun',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: _selected == 2
                            ? provider.isDarkMode
                                ? ColorValueDark.backgroundColor
                                : Colors.white
                            : provider.isDarkMode
                                ? ColorValueDark.secondaryColor
                                : ColorValue.secondaryColor),
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp. 200.000',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _selected == 2
                        ? provider.isDarkMode
                            ? ColorValueDark.backgroundColor
                            : Colors.white
                        : provider.isDarkMode
                            ? ColorValueDark.secondaryColor
                            : ColorValue.secondaryColor,
                  ),
                ),
                const Text(
                  'Rp. 240.000',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF696B),
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
