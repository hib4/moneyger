import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyger/common/color_value.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  int selectedRadio = 0;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(int number) {
    selectedRadio = number;
    themeMode = number == 0 ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class AppThemeData {
  static ThemeData getThemeLight() {
    const Color primaryColor = ColorValue.primaryColor;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      primaryColor: primaryColor,
      primarySwatch: primaryMaterialColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: ColorValue.secondaryColor,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headline2: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
        ),
        headline3: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 16,
        ),
        headline4: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 14,
        ),
        headline6: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 16,
        ),
        bodyText1: GoogleFonts.poppins(
          color: ColorValue.greyColor,
          fontSize: 12,
        ),
        bodyText2: GoogleFonts.poppins(
          color: ColorValue.greyColor,
          fontSize: 10,
        ),
      ),
    );
  }

  static ThemeData getThemeDark() {
    const Color primaryColor = ColorValueDark.primaryColor;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      primaryColor: primaryColor,
      primarySwatch: primaryMaterialColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorValueDark.backgroundColor,
      backgroundColor: ColorValueDark.backgroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: ColorValueDark.backgroundColor,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ColorValueDark.secondaryColor,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headline2: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
        ),
        headline3: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
        ),
        headline4: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
        ),
        headline6: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
        ),
        bodyText1: GoogleFonts.poppins(
          color: ColorValueDark.greyColor,
          fontSize: 12,
        ),
        bodyText2: GoogleFonts.poppins(
          color: ColorValueDark.greyColor,
          fontSize: 10,
        ),
      ),
    );
  }
}
