import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';

class ToDoListScreen extends StatefulWidget {
  ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  ToDoState toDoState = ToDoState();

  @override
  void initState() {
    super.initState();
    ToDoActions toDoActions = ToDoActions(context: context);
    toDoActions.readFromSharedPreferences();
  }

  void searchToDos(keyword) {
    ToDoActions toDoActions = ToDoActions(context: context);
    toDoActions.searchToDos(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoState>(
      builder: (context, toDos, child) => SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20, bottom: 20),
              child: CupertinoSearchTextField(
                  placeholder: 'Search ToDos',
                  onChanged: ((value) => searchToDos(value))),
            ),
            Expanded(
                child: toDos.toDoList.isEmpty
                    ? const Center(
                        child: Text(
                          'You have no ToDos',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: toDos.toDoList.length,
                                  itemBuilder: ((context, index) => Row(
                                        children: [
                                          ToDoCard(
                                            id: toDos.toDoList[index].id,
                                            title: toDos.toDoList[index].name,
                                            description: toDos
                                                .toDoList[index].description,
                                            completed:
                                                toDos.toDoList[index].completed,
                                            createdAt:
                                                toDos.toDoList[index].createdAt,
                                          )
                                        ],
                                      )))
                            ],
                          ))
                        ],
                      ))
          ],
        ),
      ),
    );
  }
}
