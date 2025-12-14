import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool isDarkMode = true;

  ThemeData getTheme() {
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme() {
    //sets to the opposite of dark mode
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
