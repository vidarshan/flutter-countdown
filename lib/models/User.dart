import 'dart:convert';

import 'package:intl/intl.dart';

class User {
  String id;
  String username;
  String password;
  DateTime createdAt;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.createdAt});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'],
        username: jsonData['username'],
        password: jsonData['password'],
        createdAt: DateTime.parse(jsonData['createdAt']));
  }

  static Map<String, dynamic> toMap(User user) => {
        'id': user.id,
        'username': user.username,
        'password': user.password,
        'createdAt': DateFormat('yyyy-MM-dd kk:mm').format(user.createdAt),
      };

  static String encode(List<User>? users) => json.encode(
        users!.map<Map<String, dynamic>>((users) => User.toMap(users)).toList(),
      );

  static List<User>? decode(String users) =>
      (json.decode(users) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();
}
