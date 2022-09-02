import 'dart:convert';

import 'package:intl/intl.dart';

class ToDo {
  String id;
  String name;
  String description;
  bool completed;
  String color;
  int createdAt;
  String nodeKey;
  String userUID;

  ToDo(
      {required this.id,
      required this.name,
      required this.description,
      required this.completed,
      required this.color,
      required this.createdAt,
      required this.nodeKey,
      required this.userUID});

  factory ToDo.fromJson(Map<String, dynamic> jsonData) {
    return ToDo(
        id: jsonData['id'],
        name: jsonData['name'],
        description: jsonData['description'],
        completed: jsonData['completed'] ?? false,
        color: jsonData['color'],
        createdAt: jsonData['createdAt'],
        nodeKey: jsonData['key'],
        userUID: jsonData['userUID']);
  }

  static Map<String, dynamic> toMap(ToDo toDo) => {
        'id': toDo.id,
        'name': toDo.name,
        'description': toDo.description,
        'completed': toDo.completed,
        'color': toDo.color,
        'createdAt': toDo.createdAt,
        'userUID': toDo.userUID
      };

  static String encode(List<ToDo>? toDos) => json.encode(
        toDos!.map<Map<String, dynamic>>((toDo) => ToDo.toMap(toDo)).toList(),
      );

  static List<ToDo>? decode(String toDos) =>
      (json.decode(toDos) as List<dynamic>)
          .map<ToDo>((item) => ToDo.fromJson(item))
          .toList();
}
