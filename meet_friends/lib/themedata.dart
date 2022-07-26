// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}

class MyTheme {
  MyTheme._();
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('#323745'),
    colorScheme: const ColorScheme.dark(),
    bottomAppBarColor: HexColor('#222634'),
    backgroundColor: HexColor('#1F2431').withOpacity(0.70),
    primaryColor: Colors.white70,
    cardColor: HexColor('#1F2431'),
    shadowColor: HexColor('#1F2431'),
    buttonColor: HexColor('#141A1E'),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    bottomAppBarColor: Colors.white70,
    backgroundColor: Colors.grey.shade100.withOpacity(0.70),
    primaryColor: const Color.fromARGB(255, 46, 45, 45),
    cardColor: Colors.white,
    shadowColor: HexColor('#1F2431'),
    buttonColor: HexColor('#5AA6FF'),
  );
}
