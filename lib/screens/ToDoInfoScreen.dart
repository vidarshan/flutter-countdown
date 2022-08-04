import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';

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
  late ToDoActions toDoActions = ToDoActions(context: context);
  ToDoState toDoState = ToDoState();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    toDoState.editListItem.id = widget.id;
    toDoState.editListItem.name = widget.title;
    toDoState.editListItem.description = widget.description;
    toDoState.editListItem.createdAt = widget.createdAt;
  }

  void editToDo(id, title, description) {
    toDoActions.editToDo(id);
    Navigator.pop(context);
  }

  void onChange(field, value) {
    if (field == 'title') {
      toDoActions.setEditToDoItem(
          widget.id, value, widget.description, widget.createdAt);
    } else {
      toDoActions.setEditToDoItem(
          widget.id, widget.title, value, widget.createdAt);
    }
  }

  void deleteToDo(id) {
    toDoActions.deleteToDo(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd kk:mm').format(widget.createdAt);

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
                    onChanged: (value) => onChange('title', value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 40,
                    child: CupertinoTextField(
                      controller: _descriptionController,
                      placeholder: 'Todo Description',
                      onChanged: (value) => onChange('description', value),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Created at ${DateFormat('yyyy-MM-dd - h:mm a').format(widget.createdAt)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton.filled(
                        onPressed: () => editToDo(
                            widget.id, widget.title, widget.description),
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
