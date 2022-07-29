import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  void addToDo(title, description) {
    ToDo newToDo = ToDo(
        id: uuid.v4(),
        name: title,
        description: description,
        createdAt: DateTime.now());
    toDos.toDoList.add(newToDo);
    toDos.update();
  }
}
