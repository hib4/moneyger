import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyger/common/color_value.dart';

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
          fontSize: 16,
        ),
        headline4: GoogleFonts.poppins(
          fontSize: 14,
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
}
