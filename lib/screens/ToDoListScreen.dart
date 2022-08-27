import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/theme/state.dart';
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
  }

  void searchToDos(keyword) {
    ToDoActions toDoActions = ToDoActions(context: context);
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference postListRef = FirebaseDatabase.instance.ref("todos");
    return StreamBuilder(
      stream: postListRef.onValue,
      builder: (context, snapshot) {
        List<ToDo> toDoList = [];
        if (snapshot.hasData &&
            snapshot.data != null &&
            (snapshot.data! as DatabaseEvent).snapshot.value != null) {
          final myMessages = Map<dynamic, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>); //typecasting
          myMessages.forEach((key, value) {
            print(key);
            final toDo = Map<String, dynamic>.from(value);
            toDoList.add(ToDo(
              id: toDo['id'],
              name: toDo['title'],
              description: toDo['description'],
              completed: toDo['completed'],
              createdAt: toDo['createdAt'],
              nodeKey: key,
            ));
          });
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: CupertinoSearchTextField(
                    placeholder: 'Search ToDos',
                    style: const TextStyle(color: Colors.grey),
                    onChanged: ((value) => searchToDos(value))),
              ),
              Container(
                  child: toDoList.isEmpty
                      ? const Center(
                          child: Text(
                            'You have no ToDos',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: toDoList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                ToDoCard(
                                  id: toDoList[index].id,
                                  title: toDoList[index].name,
                                  description: toDoList[index].description,
                                  completed: toDoList[index].completed,
                                  createdAt: toDoList[index].createdAt,
                                  nodeKey: toDoList[index].nodeKey,
                                )
                              ],
                            );
                          },
                        )))
            ],
          );
        } else {
          return const Center(
            child: Text(
              'You have no ToDos',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
