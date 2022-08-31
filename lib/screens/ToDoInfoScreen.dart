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
  final String nodeKey;

  const ToDoInfoScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.completed,
      required this.createdAt,
      required this.nodeKey})
      : super(key: key);

  @override
  State<ToDoInfoScreen> createState() => _ToDoInfoScreenState();
}

class _ToDoInfoScreenState extends State<ToDoInfoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
    toDoHelpers.updateToDo(
        id, title, description, completed, widget.createdAt, widget.nodeKey);
    Navigator.pop(context);
  }

  void deleteToDo() {
    toDoHelpers.deleteToDo(widget.nodeKey);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color.fromARGB(255, 239, 239, 239),
        navigationBar: const CupertinoNavigationBar(previousPageTitle: 'ToDos'),
        child: SafeArea(
          child: Container(
            child: Column(children: [
              CupertinoFormSection.insetGrouped(
                header: const Text('TODO INFORMATION'),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Title'),
                    placeholder: 'ToDo Title',
                    controller: _titleController,
                    onChanged: (value) => setState(() {
                      title = value;
                    }),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Description'),
                    placeholder: 'ToDo Description',
                    controller: _descriptionController,
                    onChanged: (value) => setState(() {
                      description = value;
                    }),
                  ),
                ],
              ),
              CupertinoFormSection.insetGrouped(
                header: const Text('TODO STATUS'),
                children: [
                  CupertinoFormRow(
                      child: Row(
                    children: [
                      const Text(
                        'Complete ToDo',
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                          value: completed,
                          onChanged: (value) => setState(() {
                                completed = value;
                              }))
                    ],
                  ))
                ],
              ),
              CupertinoFormSection.insetGrouped(
                header: const Text('OTHER INFORMATION'),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Created At'),
                    initialValue: DateFormat('yyyy-MM-dd kk:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(widget.createdAt)),
                    enabled: false,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Updated At'),
                    initialValue: DateFormat('yyyy-MM-dd kk:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(widget.createdAt)),
                    enabled: false,
                  ),
                ],
              ),
              CupertinoFormSection.insetGrouped(
                  header: const Text('ACTIONS'),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                          onPressed: () => editToDo(widget.id, title,
                              description, completed, widget.createdAt),
                          child: const Text('Edit Todo')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                            color: Colors.redAccent,
                            onPressed: () => deleteToDo(),
                            child: const Text('Delete Todo')),
                      ),
                    ),
                  ]),
            ]),
          ),
        ));
  }
}
