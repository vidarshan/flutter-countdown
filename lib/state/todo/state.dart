import 'package:flutter/material.dart';
import 'package:to_dos/models/Todo.dart';

class ToDoState with ChangeNotifier {
  late List<ToDo> toDoList = [];
  var search = '';
  var notificationCount = 0;

  void update() {
    notifyListeners();
  }
}
