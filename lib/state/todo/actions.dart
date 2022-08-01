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
  late ToDoState toDoTemp;
  var uuid = const Uuid();

  ToDoActions({required this.context}) {
    toDos = Provider.of(context, listen: false);
    toDoTemp = toDos;
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

  void setEditToDoItem(id, title, description, createdAt) {
    toDos.editListItem.id = id;
    toDos.editListItem.name = title;
    toDos.editListItem.description = description;
    toDos.editListItem.createdAt = createdAt;
  }

  void editToDo(id) {
    var currentToDoList = toDos.toDoList;
    var search = currentToDoList.indexWhere((element) => element.id == id);
    currentToDoList[search] = toDos.editListItem;
    toDos.update();
  }

  void deleteToDo(id) {
    var currentToDoList = toDos.toDoList;
    var search = currentToDoList.indexWhere((element) => element.id == id);
    currentToDoList.removeAt(search);
    toDos.update();
  }

  void searchToDos(keyword) {
    toDos.search = keyword;
    var currentToDoList = toDos.toDoList;
    late List<ToDo> searchList = [];
    if (keyword == '') {
      readFromSharedPreferences();
    } else {
      for (var element in currentToDoList) {
        {
          if (element.name.contains(keyword)) {
            print(element.name);
            searchList.add(element);
          }
        }
      }
    }

    toDos.toDoList = searchList;
    toDos.update();
  }
}
