library to_dos.toDoHelper;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

final toDoListRef = FirebaseDatabase.instance.ref('todos');
final notificationRef = FirebaseDatabase.instance.ref('notifications');
FirebaseAuth auth = FirebaseAuth.instance;

void readToDos() {}

void createNotification(title, description, todoID) {
  DatabaseReference newNotificationRef = notificationRef.push();
  Uuid uuid = const Uuid();
  newNotificationRef.set({
    'id': uuid.v4(),
    'title': title,
    'description': description,
    'createdAt': ServerValue.timestamp,
    'todoID': todoID,
    'userUID': auth.currentUser?.uid,
  });
}

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

void updateToDo(id, title, description, completed, createdAt, nodeKey) {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('todos/$nodeKey');
  ref.update({
    "title": title,
    "description": description,
    "completed": completed,
  });
  if (completed == true) {
    createNotification('Completed $title!', 'Nice work.', id);
  }
}

void deleteToDo(nodekey) {
  DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$nodekey");
  ref.remove();
}

void deleteNotification(nodekey) {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("notifications/$nodekey");
  ref.remove();
}
