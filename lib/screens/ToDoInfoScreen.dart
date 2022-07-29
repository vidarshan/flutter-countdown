import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ToDoInfoScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  const ToDoInfoScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.createdAt})
      : super(key: key);

  @override
  State<ToDoInfoScreen> createState() => _ToDoInfoScreenState();
}

class _ToDoInfoScreenState extends State<ToDoInfoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
  }

  void editToDo() {}

  void deleteToDo() {}

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd kk:mm').format(widget.createdAt);

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.title),
                SizedBox(
                  height: 40,
                  child: CupertinoTextField(
                    placeholder: 'Todo Title',
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    onChanged: (value) => {print(value)},
                  ),
                ),
                Text(widget.id),
                Text(formattedDate),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 40,
                    child: CupertinoTextField(
                      controller: _descriptionController,
                      placeholder: 'Todo Description',
                      onChanged: (value) => {print(value)},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton.filled(
                        onPressed: editToDo, child: const Text('Edit Todo')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton(
                        color: Colors.redAccent,
                        onPressed: editToDo,
                        child: const Text('Delete Todo')),
                  ),
                ),
              ]),
        ));
  }
}
