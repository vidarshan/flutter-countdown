import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:uuid/uuid.dart';

class ToDoActions {
  final BuildContext context;
  late ToDoState toDos;
  var uuid = const Uuid();

  ToDoActions({required this.context}) {
    toDos = Provider.of(context, listen: false);
  }

  Future<void> addToSharedPreferences(List<ToDo> tList) async {
    final prefs = await SharedPreferences.getInstance();
    var encodedToDoList = ToDo.encode(toDos.toDoList);
    prefs.setString('toDoList', encodedToDoList);
  }

  Future<void> readFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('toDoList');
    var encodedToDoList = prefs.getString('toDoList');
    print('Decoded todolist $encodedToDoList');
    if (encodedToDoList == null) {
      print('null');
    } else {
      var decodedToDoList = ToDo.decode(encodedToDoList);
      print('Decoded todolist $decodedToDoList');
    }
  }

  void addToDo(title, description) {
    ToDo newToDo = ToDo(
        id: uuid.v4(),
        name: title,
        description: description,
        createdAt: DateTime.now());
    toDos.toDoList.add(newToDo);
    addToSharedPreferences(toDos.toDoList);
    readFromSharedPreferences();
    toDos.update();
  }
}
