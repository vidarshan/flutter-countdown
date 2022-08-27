import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_dos/models/User.dart';
import 'package:to_dos/state/user/state.dart';
import 'package:uuid/uuid.dart';

class UserActions {
  final BuildContext context;
  late UserState user;
  var uuid = const Uuid();

  UserActions({required this.context}) {
    user = Provider.of(context, listen: false);
  }

  void readFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var encodedUserList = prefs.getString('usersList');
    if (encodedUserList == null) {
      user.usersList = [];
    } else {
      var decodedUserList = User.decode(encodedUserList);
      user.usersList = decodedUserList!;
    }
    user.update();
  }

  Future<void> addToSharedPreferences(List<User> uList) async {
    final prefs = await SharedPreferences.getInstance();
    var encodedToDoList = User.encode(user.usersList);
    prefs.setString('usersList', encodedToDoList);
  }

  void register(username, password) {
    readFromSharedPreferences();
    for (var element in user.usersList) {
      if (element.username == username) {
        user.userError = 'User Exists';
      }
    }

    if (user.userError != 'User Exists') {
      var newUser = User(
          id: uuid.v4(),
          username: username,
          password: password,
          createdAt: DateTime.now());
      user.usersList.add(newUser);
      addToSharedPreferences(user.usersList);
      user.currentUser = newUser;
    }
    user.update();
  }

  void login(email, password) {}
}
