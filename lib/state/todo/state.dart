import 'package:flutter/material.dart';
import 'package:to_dos/models/Todo.dart';

class ToDoState with ChangeNotifier {
  List<ToDo> toDoList = [];

  void update() {
    notifyListeners();
  }
}
