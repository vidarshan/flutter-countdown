import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoInfoScreen extends StatefulWidget {
  final String title;
  final String description;
  final int id;

  const ToDoInfoScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  State<ToDoInfoScreen> createState() => _ToDoInfoScreenState();
}

class _ToDoInfoScreenState extends State<ToDoInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
        child: Center(
          child: Text(widget.description),
        ));
  }
}
