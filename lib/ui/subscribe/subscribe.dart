import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/widget/subscribe/expansion.dart';
import 'package:moneyger/ui/widget/subscribe/subscribe_card.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  bool _isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/logo2.svg',
                width: 86.5,
                height: 97.24,
              ),
              const SizedBox(
                height: 13,
              ),
              const Text(
                'Moneyger Premium',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorValue.secondaryColor,
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
              const Text(
                'FAQ Tentang Moneyger Premium',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorValue.secondaryColor),
              ),
              const Divider(
                height: 16,
                thickness: 1,
                color: Color(0xFFDADADA),
                endIndent: 70,
                indent: 70,
              ),
              const SizedBox(
                height: 23,
              ),
              const SizedBox(
                height: 16,
              ),

              // FAQ
              const ExpansionWidget(),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pilih Paket',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorValue.secondaryColor),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _buttonbulanan(),
              const SizedBox(
                height: 21,
              ),
              _buttontahunan(),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_isSelected == true) {
                      setState(() {
                        _isSelected == !_isSelected;
                      });
                    }
                  },
                  child: const Text('Coba Gratis & Langganan')),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonbulanan() {
    return GestureDetector(
      onTap: () {
        if (_isSelected == false) {
          setState(() {
            _isSelected == !_isSelected;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(21, 17, 21, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _isSelected ? ColorValue.secondaryColor : Colors.white,
            border: Border.all(color: ColorValue.secondaryColor)),
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
                      color: _isSelected
                          ? Colors.white
                          : ColorValue.secondaryColor)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                      color: _isSelected
                          ? Colors.white
                          : ColorValue.secondaryColor),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    '30 Hari Trial & Bayar penuh satu bulan',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: _isSelected
                            ? const Color(0xFFE9E8E8)
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
                  color:
                      _isSelected ? Colors.white : ColorValue.secondaryColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttontahunan() {
    return GestureDetector(
      onDoubleTap: () {
        if (_isSelected == true) {
          setState(() {
            _isSelected == !_isSelected;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(21, 17, 21, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _isSelected ? Colors.white : ColorValue.secondaryColor,
            border: Border.all(color: ColorValue.secondaryColor)),
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
                      color: _isSelected
                          ? ColorValue.secondaryColor
                          : Colors.white)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                          color: _isSelected
                              ? ColorValue.secondaryColor
                              : Colors.white),
                    ),
                    Text(
                      '/16.000 per bulan',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: _isSelected
                              ? ColorValue.secondaryColor
                              : Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    '30 Hari Trial & Bayar penuh satu tahun',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: _isSelected
                            ? ColorValue.secondaryColor
                            : const Color(0xFFE9E8E8)),
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
                    color:
                        _isSelected ? ColorValue.secondaryColor : Colors.white,
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
            )
          ],
        ),
      ),
    );
  }
}
