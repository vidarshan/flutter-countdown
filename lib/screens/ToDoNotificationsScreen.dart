import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/state/theme/actions.dart';
import 'package:to_dos/state/todo/actions.dart';

class ToDoNotificationsScreen extends StatefulWidget {
  ToDoNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<ToDoNotificationsScreen> createState() =>
      _ToDoNotificationsScreenState();
}

class _ToDoNotificationsScreenState extends State<ToDoNotificationsScreen> {
  void changeTheme() {
    ThemeActions themeActions = ThemeActions(context: context);
    var currentTheme = themeActions.getTheme();
    themeActions.setTheme(currentTheme == 'dark' ? 'light' : 'dark');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      // child: Text('You have no new notifications'),
      child: CupertinoButton.filled(
          onPressed: (() => changeTheme()), child: const Text('press')),
    ));
  }
}
