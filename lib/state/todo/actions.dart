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

  void readFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('toDoList');
    var encodedToDoList = prefs.getString('toDoList');
    if (encodedToDoList == null) {
      toDos.toDoList = [];
    } else {
      var decodedToDoList = ToDo.decode(encodedToDoList);
      toDos.toDoList = decodedToDoList!;
    }

    toDos.update();
  }

  Future<List<ToDo>?> readFromSharedPreferencesF() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('toDoList');
    var encodedToDoList = prefs.getString('toDoList');
    var decodedToDoList = ToDo.decode(encodedToDoList!);
    toDos.update();
    return decodedToDoList;
  }

  Future<void> addToSharedPreferences(List<ToDo> tList) async {
    final prefs = await SharedPreferences.getInstance();
    var encodedToDoList = ToDo.encode(toDos.toDoList);
    prefs.setString('toDoList', encodedToDoList);
  }

  void getToDoState() {
    readFromSharedPreferences();
  }

  void addToDo(title, description) {
    ToDo newToDo = ToDo(
        id: uuid.v4(),
        name: title,
        description: description,
        createdAt: DateTime.now());
    toDos.toDoList.add(newToDo);
    addToSharedPreferences(toDos.toDoList);
    toDos.update();
  }
}
