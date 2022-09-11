import 'package:flutter/material.dart';
import 'package:to_dos/models/ToDoNotification.dart';

class ToDoNotficationsState with ChangeNotifier {
  late int notificationsCount = 0;

  void update() {
    notifyListeners();
  }
}
