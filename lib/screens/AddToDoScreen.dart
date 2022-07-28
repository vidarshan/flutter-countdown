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
  final myController = TextEditingController();
  late ToDoActions toDoActions = ToDoActions(context: context);
  String toDoName = '';
  String toDoDescription = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void addToDo() {
    ToDo newTodo = ToDo(name: toDoName, description: toDoDescription);
    toDoActions.addToDo(newTodo);
    Navigator.pop(context);
  }

  void setAddToDoFormFieldValues(field, value) {
    if (field == 'name') {
      toDoName = value;
    } else {
      toDoDescription = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
          const CupertinoNavigationBar(middle: Text('Create new Todo')),
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
