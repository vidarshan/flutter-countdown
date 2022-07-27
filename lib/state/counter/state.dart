import 'package:flutter/material.dart';

class CounterState with ChangeNotifier {
  int counter = 0;

  void update() {
    notifyListeners();
  }
}
