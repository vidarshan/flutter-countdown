import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier {
  late String currentTheme = 'light';

  void update() {
    notifyListeners();
  }
}
