library to_dos.toDoHelper;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

final toDoListRef = FirebaseDatabase.instance.ref('todos');
FirebaseAuth auth = FirebaseAuth.instance;

void readToDos() {}

void createNewToDo(title, description, completed, color) {
  DatabaseReference newToDoRef = toDoListRef.push();
  Uuid uuid = const Uuid();

  newToDoRef.set({
    'id': uuid.v4(),
    'title': title,
    'description': description,
    'completed': false,
    'color': color,
    'createdAt': ServerValue.timestamp,
    'userUID': auth.currentUser?.uid
  });
}

// void searchToDos(keyword) {
//   Query postListRef = FirebaseDatabase.instance
//       .ref("todos")
//       .orderByChild('title')
//       .equalTo(keyword).once('value').then((value) => value.snapshot.);

//   postListRef.onValue.length;
//   print(postListRef);
// }

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
