import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      scaffoldBackgroundColor: kSecondaryBackgroundColor,
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColor,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: kPrimaryColor, selectionColor: kPrimaryColor));
}

InputDecorationTheme inputDecorationTheme() {
  return const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: kPrimaryColor),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    iconColor: kPrimaryColor,
  );
}

TextTheme textTheme() {
  return GoogleFonts.poppinsTextTheme().apply(
    bodyColor: kPrimaryTextColor,
    displayColor: kPrimaryTextColor,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: kSecondaryBackgroundColor,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: kPrimaryTextColor),
    textTheme: TextTheme(
      headline6: TextStyle(color: kPrimaryTextColor, fontSize: 18),
    ),
  );
}
