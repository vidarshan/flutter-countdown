import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:to_dos/helpers/ToDo.dart' as toDoHelpers;

class ToDoInfoScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final int createdAt;

  const ToDoInfoScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.completed,
      required this.createdAt})
      : super(key: key);

  @override
  State<ToDoInfoScreen> createState() => _ToDoInfoScreenState();
}

class _ToDoInfoScreenState extends State<ToDoInfoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late bool completed;

  late String title;
  late String description;

  late ToDoActions toDoActions = ToDoActions(context: context);
  ToDoState toDoState = ToDoState();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    completed = widget.completed;
    title = widget.title;
    description = widget.description;
  }

  void editToDo(id, title, description, completed, createdAt) {
    toDoHelpers.updateToDo(id, title, description, completed, widget.createdAt);
    Navigator.pop(context);
  }

  void deleteToDo(id) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(previousPageTitle: 'ToDos'),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: CupertinoTextField(
                    placeholder: 'Todo Title',
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => setState(() {
                      title = value;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 40,
                    child: CupertinoTextField(
                        controller: _descriptionController,
                        placeholder: 'Todo Description',
                        onChanged: (value) => setState(() {
                              description = value;
                            })),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Complete ToDo',
                        style: TextStyle(
                            color: Color.fromARGB(255, 189, 189, 189)),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                          value: completed,
                          onChanged: (value) => setState(() {
                                completed = value;
                              }))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Created at ${DateFormat('yyyy-MM-dd kk:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.createdAt))}',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton.filled(
                        onPressed: () => editToDo(widget.id, title, description,
                            completed, widget.createdAt),
                        child: const Text('Edit Todo')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton(
                        color: Colors.redAccent,
                        onPressed: () => deleteToDo(widget.id),
                        child: const Text('Delete Todo')),
                  ),
                ),
              ]),
        ));
  }
}
