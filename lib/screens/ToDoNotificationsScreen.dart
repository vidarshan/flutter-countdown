import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoNotificationsScreen extends StatefulWidget {
  ToDoNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<ToDoNotificationsScreen> createState() =>
      _ToDoNotificationsScreenState();
}

class _ToDoNotificationsScreenState extends State<ToDoNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
      // child: Text('You have no new notifications'),
      child: CupertinoButton.filled(child: Text('press'), onPressed: null),
    ));
  }
}
