import 'package:flutter/material.dart';
import 'package:to_dos/models/User.dart';

class UserState with ChangeNotifier {
  late User currentUser =
      User(id: '', username: '', password: '', createdAt: DateTime.now());
  late List<User> usersList = [];
  late String userError = '';
  late User user =
      User(id: '', username: '', password: '', createdAt: DateTime.now());

  void update() {
    notifyListeners();
  }
}
