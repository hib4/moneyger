import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:provider/provider.dart';

class SubcribeCard extends StatefulWidget {
  const SubcribeCard({Key? key}) : super(key: key);

  @override
  State<SubcribeCard> createState() => _SubcribeCardState();
}

class _SubcribeCardState extends State<SubcribeCard> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: const EdgeInsets.only(top: 12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: ColorValue.borderColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            'Apa yang baru di Moneyger Premium?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: provider.isDarkMode
                  ? ColorValueDark.secondaryColor
                  : ColorValue.secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          item('consultation', 'Konsultasi Keuangan',
              'Dapatkan fitur konsultasi keungan dengan para ahli', context),
          item('darkmode', 'Mode Gelap',
              'Atur keunangan kamu lebih nyaman dengan mode gelap', context),
          item(
              'stats',
              'Statistik Kuangan',
              'Kamu bisa mendapatkan jangkaun statistik keuangan bulanan lebih lengkap',
              context),
          item2('cost', 'Penganggaran',
              'Kamu dapat mengunakan anggaran yang tidak terbatas', context),
        ],
      ),
    );
  }

  Widget item(
      String icon, String title, String subtitle, BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 35,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5.5),
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                    color: provider.isDarkMode
                        ? ColorValueDark.darkColor
                        : Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(
                  'assets/svg/$icon.svg',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: provider.isDarkMode
                            ? ColorValueDark.secondaryColor
                            : ColorValue.secondaryColor),
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: ColorValue.greyColor),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        const Divider(
          color: ColorValue.borderColor,
          thickness: 1,
        ),
        const SizedBox(
          height: 11,
        )
      ],
    );
  }

  Widget item2(
      String icon, String title, String subtitle, BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 35,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5.5),
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                    color: provider.isDarkMode
                        ? ColorValueDark.darkColor
                        : Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(
                  'assets/svg/$icon.svg',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: provider.isDarkMode
                            ? ColorValueDark.secondaryColor
                            : ColorValue.secondaryColor),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: ColorValue.greyColor),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 11,
        )
      ],
    );
  }
}
