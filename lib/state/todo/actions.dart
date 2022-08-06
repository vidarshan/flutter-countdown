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

  void addToDo(title, description, completed) {
    ToDo newToDo = ToDo(
        id: uuid.v4(),
        name: title,
        description: description,
        completed: completed,
        createdAt: DateTime.now());
    toDos.toDoList.add(newToDo);
    addToSharedPreferences(toDos.toDoList.reversed.toList());
    toDos.update();
  }

  void editToDo(id, title, description, completed, createdAt) {
    var search = toDos.toDoList.indexWhere((element) => element.id == id);
    toDos.toDoList[search].name = title;
    toDos.toDoList[search].description = description;
    toDos.toDoList[search].completed = completed;
    if (toDos.toDoList[search].completed) {
      toDos.notificationCount++;
    }
    addToSharedPreferences(toDos.toDoList);
    toDos.update();
  }

  void deleteToDo(id) {
    var currentToDoList = toDos.toDoList;
    var search = currentToDoList.indexWhere((element) => element.id == id);
    currentToDoList.removeAt(search);
    addToSharedPreferences(currentToDoList.reversed.toList());
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
            searchList.add(element);
          }
        }
      }
    }

    toDos.toDoList = searchList.reversed.toList();
    toDos.update();
  }
}
