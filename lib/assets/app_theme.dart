import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_palette.dart';

class TeAppThemeData {
  static const double contentMargin = 32 * 2;
  static String? teFont = GoogleFonts.inter().fontFamily;

  ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primaryColorDark: TeAppColorPalette.green,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: TeAppColorPalette.green,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TeAppColorPalette.green,
        foregroundColor: TeAppColorPalette.black,
        elevation: 44,
        iconSize: 32,
      ),

      // APPBAR //
      appBarTheme: AppBarTheme(
        backgroundColor: TeAppColorPalette.green,
        foregroundColor: TeAppColorPalette.black,
        elevation: 12,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: TeAppColorPalette.black,
          fontSize: 26,
          fontFamily: teFont,
          fontWeight: FontWeight.bold,
        ),
      ),

      // DRAWER //
      drawerTheme: const DrawerThemeData(
        backgroundColor: TeAppColorPalette.blackLight,
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),

      // BOTTOM NAV BAR //
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: TeAppColorPalette.green,
        selectedItemColor: TeAppColorPalette.black,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 42),
        unselectedIconTheme: IconThemeData(size: 32),
        elevation: 12,
      ),

      // ElEVATED BUTTON //
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: TeAppColorPalette.black,
          )),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
          backgroundColor:
              MaterialStateProperty.all<Color>(TeAppColorPalette.green),
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all(12),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
      ),

      // SNACK BAR //
      snackBarTheme: const SnackBarThemeData(
        backgroundColor:
            TeAppColorPalette.green, // Set the desired background color
        contentTextStyle: TextStyle(
            color: TeAppColorPalette.black), // Set the desired text color
      ),

      // TEXT BUTTON //
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            TeAppColorPalette.black,
          ),
        ),
      ),

      // CARD //
      cardTheme: CardTheme(
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: TeAppColorPalette.white,
      ),

      // TEXTFIELD //
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: TeAppColorPalette.white),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TeAppColorPalette.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),

      // TIME PICKER //
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: TeAppColorPalette.black,
        dialHandColor: TeAppColorPalette.green,
        dayPeriodColor: TeAppColorPalette.green,

        dialBackgroundColor: TeAppColorPalette.blackLight,
        hourMinuteColor: TeAppColorPalette.blackLight,
        dayPeriodTextColor: TeAppColorPalette.black,
        hourMinuteTextColor: TeAppColorPalette.green,
        // You can customize other properties as well
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: TeAppColorPalette.black,
        headerBackgroundColor: TeAppColorPalette.blackLight,
        headerForegroundColor: TeAppColorPalette.white,
        todayBorder: const BorderSide(color: TeAppColorPalette.green),
        dividerColor: TeAppColorPalette.green,
        todayBackgroundColor: MaterialStateProperty.all<Color>(
          TeAppColorPalette.black,
        ),
        dayOverlayColor: MaterialStateProperty.all<Color>(
          TeAppColorPalette.green,
        ),
        todayForegroundColor: MaterialStateProperty.all<Color>(
          TeAppColorPalette.green,
        ),
        rangeSelectionOverlayColor: MaterialStateProperty.all<Color>(
          TeAppColorPalette.green,
        ),
        rangePickerBackgroundColor: TeAppColorPalette.green,
        dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return TeAppColorPalette.green;
          } else {
            return TeAppColorPalette.black;
          }
        }),
        dayForegroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return TeAppColorPalette.black;
          } else {
            return TeAppColorPalette.white;
          }
        }),
        surfaceTintColor: TeAppColorPalette.green,
        rangePickerHeaderForegroundColor: TeAppColorPalette.white,
      ),

      splashColor: TeAppColorPalette.green,
      scaffoldBackgroundColor: TeAppColorPalette.blackLight,

      // GENERAL //
      brightness: Brightness.dark,
      primaryColor: TeAppColorPalette.black,
      fontFamily: teFont,

      textTheme: const TextTheme(
        // FOR TITLES //
        titleMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: TeAppColorPalette.black,
        ),

        titleLarge: TextStyle(
          fontSize: 54,
          fontWeight: FontWeight.w900,
          color: TeAppColorPalette.black,
        ),

        // FOR BUTTONS //
        labelMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: TeAppColorPalette.black,
        ),

        displayLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w900,
            color: TeAppColorPalette.white),

        displayMedium: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w400,
            color: TeAppColorPalette.white),

        displaySmall: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: TeAppColorPalette.white),
      ),
    );
  }
}
