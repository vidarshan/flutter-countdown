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
}
