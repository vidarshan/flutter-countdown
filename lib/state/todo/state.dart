import 'package:flutter/material.dart';
import 'package:to_dos/models/Todo.dart';

class ToDoState with ChangeNotifier {
  late List<ToDo> toDoList = [];
  late ToDo editListItem =
      ToDo(id: '', name: '', description: '', createdAt: DateTime.now());
  var search = '';

  void update() {
    notifyListeners();
  }
}
