import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/todo/actions.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({Key? key}) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  late ToDoActions toDoActions = ToDoActions(context: context);
  String toDoName = '';
  String toDoDescription = '';
  bool completed = false;

  @override
  void initState() {
    super.initState();
  }

  void addToDo() {
    toDoActions.addToDo(toDoName, toDoDescription, completed);

    Navigator.pop(context);
  }

  void setAddToDoFormFieldValues(field, value) {
    if (field == 'name') {
      toDoName = value;
    } else {
      toDoDescription = value;
    }
  }

  void toggleComplete = () => {};

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: 'ToDos',
      ),
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
                  textInputAction: TextInputAction.next,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  onChanged: (value) => {toDoName = value},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  child: CupertinoTextField(
                    placeholder: 'Todo Description',
                    onChanged: (value) => {toDoDescription = value},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const Text(
                      'Complete ToDo',
                      style:
                          TextStyle(color: Color.fromARGB(255, 189, 189, 189)),
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  child: CupertinoButton.filled(
                      onPressed: addToDo, child: const Text('Add Todo')),
                ),
              )
            ]),
      ),
    );
  }
}
