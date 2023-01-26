import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:provider/provider.dart';

class SwitchThemePage extends StatefulWidget {
  const SwitchThemePage({Key? key}) : super(key: key);

  @override
  State<SwitchThemePage> createState() => _SwitchThemePageState();
}

class _SwitchThemePageState extends State<SwitchThemePage> {
  int _selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    _selectedRadio = provider.isDarkMode ? 1 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ganti Tema",
          style: TextStyle(
            color: provider.isDarkMode
                ? Colors.white
                : ColorValueDark.backgroundColor,
          ),
        ),
        backgroundColor:
            provider.isDarkMode ? ColorValueDark.backgroundColor : Colors.white,
        iconTheme: IconThemeData(
          color: provider.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            RadioListTile(
              value: 0,
              groupValue: provider.selectedRadio,
              onChanged: (int? value) {
                if (provider.selectedRadio != 0) {
                  provider.toggleTheme(0);
                }
              },
              title: const Text('Tema Terang'),
            ),
            RadioListTile(
              value: 1,
              groupValue: provider.selectedRadio,
              onChanged: (int? value) {
                if (provider.selectedRadio != 1) {
                  provider.toggleTheme(1);
                }
              },
              title: const Text('Tema Gelap'),
            ),
          ],
        ),
      ),
    );
  }
}
