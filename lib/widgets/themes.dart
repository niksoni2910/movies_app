import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: creamColor,
      // buttonColor: darkBluishColor,
      hintColor: darkBluishColor,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        toolbarTextStyle: Theme.of(context).textTheme.bodyMedium,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ));
  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.black,
      canvasColor: darkcreamColor,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarTextStyle: Theme.of(context).textTheme.bodyMedium,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white,brightness: Brightness.dark,));

  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkcreamColor = Vx.gray900;
  static Color darkBluishColor = const Color(0xfff403b58);
  static Color lightBluishColor = Vx.indigo500;
}
