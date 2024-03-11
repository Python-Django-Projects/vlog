import 'package:flutter/material.dart';

import 'color_manager.dart';

_inputBorder([Color color = Colors.grey]) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color));
}

ThemeData get appTheme => ThemeData(
      fontFamily: "Poppins",
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kMainColor,
        primary: kMainColor,
        brightness: Brightness.light,
        onPrimary: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      secondaryHeaderColor: kMainTextColor,
      dividerColor: kDividerColor,
      disabledColor: Colors.grey.shade700,
      hintColor: Colors.grey.shade500,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kMainColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(fontSize: 14),
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: const TextStyle(fontSize: 14),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        border: _inputBorder(),
        focusedBorder: _inputBorder(kMainColor),
        errorBorder: _inputBorder(kRedColor),
        enabledBorder: _inputBorder(),
        disabledBorder: _inputBorder(),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        elevation: 0.0,
      ),
    );

ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    primaryColor: kMainColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kMainColor,
      brightness: Brightness.dark,
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xff242424),
    cardColor: const Color(0xff1b1b1b),
    cardTheme: CardTheme(
      color: const Color(0xff1b1b1b),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: const Color(0xff1b1b1b),
      iconTheme: IconThemeData(color: Colors.white.withOpacity(0.5)),
      actionsIconTheme: IconThemeData(color: Colors.white.withOpacity(0.5)),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    ));
