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
    'completed': true,
    'createdAt': ServerValue.timestamp
  });
}
