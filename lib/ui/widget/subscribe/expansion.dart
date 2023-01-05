import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({Key? key}) : super(key: key);

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        expansion('Apa itu Moneyger Premium?',
            'Moneyger Premium merupakan sistem membership dimana pengguna Moneyger Premium dapat menikmati fitur-fitur dan manfaat lebih banyak.'),
        expansion('Tipe langganan apa saja yang tersedia di Moneyger Premium?',
            'Untuk berlangganan di Moneyger Premium memiliki 2 tipe langganan yaitu bulanan dan tahunan.'),
        expansion('Apakah saya bisa dapat mencoba free trial?',
            'Kamu hanya dapat mencoba fitur free trial pada konsultasi keuangan'),
      ],
    );
  }

  Widget expansion(String header, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF3F3F3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5F6368),
            ),
          ),
          child: ExpansionTile(
            backgroundColor: const Color(0xFFF3F3F3),
            title: Text(
              header,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF5F6368),
                  fontWeight: FontWeight.w500),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 21),
                child: Text(
                  body,
                  style:
                      const TextStyle(fontSize: 10, color: Color(0xFF5F6368)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
