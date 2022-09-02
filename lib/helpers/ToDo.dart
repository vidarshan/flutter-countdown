library to_dos.toDoHelper;

import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

final toDoListRef = FirebaseDatabase.instance.ref('todos');

void readToDos() {}

void createNewToDo(title, description, completed) {
  DatabaseReference newToDoRef = toDoListRef.push();
  Uuid uuid = const Uuid();

  newToDoRef.set({
    'id': uuid.v4(),
    'title': title,
    'description': description,
    'completed': false,
    'createdAt': ServerValue.timestamp
  });
}

void updateToDo(id, title, description, completed, createdAt, nodeKey) {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('todos/$nodeKey');
  ref.update({
    "title": title,
    "description": description,
    "completed": completed,
  });
}

void deleteToDo(nodekey) {
  DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$nodekey");
  ref.remove();
}
