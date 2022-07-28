import 'package:flutter/cupertino.dart';
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

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void addToDo() {
    ToDo newTodo = ToDo(name: 'Buy Milk', description: 'Buy 4L of milk');
    toDoActions.addToDo(newTodo);
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
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
              // Row(
              //   children: const [
              //     Text(
              //       'Title',
              //       textAlign: TextAlign.left,
              //     )
              //   ],
              // ),
              const SizedBox(
                height: 40,
                child: CupertinoTextField(
                  placeholder: 'Todo Title',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  child: CupertinoTextField(
                    placeholder: 'Todo Description',
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
