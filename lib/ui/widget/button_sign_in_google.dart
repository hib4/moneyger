import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:provider/provider.dart';

class ButtonSignInGoogle extends StatelessWidget {
  const ButtonSignInGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<ThemeProvider>(context);

    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: provider.isDarkMode ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/google.png'),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Masuk dengan Google',
            style: textTheme.bodyText1!.copyWith(
              color: provider.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
