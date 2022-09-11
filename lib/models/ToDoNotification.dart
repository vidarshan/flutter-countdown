import 'dart:convert';

import 'package:intl/intl.dart';

class ToDoNotification {
  String id;
  String title;
  String description;
  int createdAt;
  String todoID;
  String userUID;
  String nodeKey;

  ToDoNotification(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.todoID,
      required this.userUID,
      required this.nodeKey});

  factory ToDoNotification.fromJson(Map<String, dynamic> jsonData) {
    return ToDoNotification(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        createdAt: jsonData['createdAt'],
        nodeKey: jsonData['nodeKey'],
        todoID: jsonData['todoID'],
        userUID: jsonData['userUID']);
  }

  static Map<String, dynamic> toMap(ToDoNotification toDoNotification) => {
        'id': toDoNotification.id,
        'title': toDoNotification.title,
        'description': toDoNotification.description,
        'createdAt': toDoNotification.createdAt,
        'nodeKey': toDoNotification.nodeKey,
        'userUID': toDoNotification.userUID,
        'todoID': toDoNotification.todoID
      };

  static String encode(List<ToDoNotification>? toDoNotification) => json.encode(
        toDoNotification!
            .map<Map<String, dynamic>>(
                (toDoNotification) => ToDoNotification.toMap(toDoNotification))
            .toList(),
      );

  static List<ToDoNotification>? decode(String toDoNotification) =>
      (json.decode(toDoNotification) as List<dynamic>)
          .map<ToDoNotification>((item) => ToDoNotification.fromJson(item))
          .toList();
}
