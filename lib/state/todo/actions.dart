import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/todo/state.dart';

class ToDoActions {
  final BuildContext context;
  late ToDoState toDos;

  ToDoActions({required this.context}) {
    toDos = Provider.of(context, listen: false);
  }

  void addToDo(ToDo todo) {
    toDos.toDoList.add(todo);
    toDos.update();
  }
}
