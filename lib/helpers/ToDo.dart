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

void updateToDo(id, title, description, completed, createdAt) {
  DatabaseReference ref = FirebaseDatabase.instance.ref("todos");
  // Timestamp timestamp = Timestamp.fromDate(createdAt);
  // print(timestamp);

  ref.update({
    "$id/id": id,
    "$id/title": title,
    "$id/description": description,
    "$id/completed": completed,
    "$id/createdAt": 1661579857,
  });
}
