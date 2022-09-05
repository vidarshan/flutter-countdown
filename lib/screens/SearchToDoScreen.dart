import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/helpers/ToDo.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/todo/actions.dart';

class SearchToDoScreen extends StatefulWidget {
  SearchToDoScreen({Key? key}) : super(key: key);

  @override
  State<SearchToDoScreen> createState() => _SearchToDoScreenState();
}

class _SearchToDoScreenState extends State<SearchToDoScreen> {
  late String toDoName;

  @override
  void initState() {
    super.initState();
    setState(() {
      toDoName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(toDoName);
    Query postListRef = FirebaseDatabase.instance
        .ref("todos")
        .orderByChild('title')
        .startAt(toDoName)
        .endAt("$toDoName\uf8ff");
    return CupertinoPageScaffold(
        child: StreamBuilder(
      stream: postListRef.onValue,
      builder: (context, snapshot) {
        List<ToDo> toDoList = [];
        if (snapshot.hasData &&
            snapshot.data != null &&
            (snapshot.data! as DatabaseEvent).snapshot.value != null &&
            toDoName != '') {
          final myMessages = Map<dynamic, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>);
          myMessages.forEach((key, value) {
            final toDo = Map<String, dynamic>.from(value);
            toDoList.add(ToDo(
                id: toDo['id'],
                name: toDo['title'],
                description: toDo['description'],
                completed: toDo['completed'],
                color: toDo['color'],
                createdAt: toDo['createdAt'],
                nodeKey: key,
                userUID: toDo['userUID']));
          });
        }
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 20, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoSearchTextField(
                      placeholder: 'Search ToDos',
                      style: const TextStyle(color: Colors.grey),
                      onChanged: ((value) => setState(() {
                            toDoName = value;
                          }))),
                ),
              ),
              toDoList.isEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        'No matching ToDos found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: toDoList.length,
                      itemBuilder: (context, index) {
                        return ToDoCard(
                          id: toDoList[index].id,
                          title: toDoList[index].name,
                          description: toDoList[index].description,
                          completed: toDoList[index].completed,
                          color: toDoList[index].color,
                          createdAt: toDoList[index].createdAt,
                          nodeKey: toDoList[index].nodeKey,
                        );
                      },
                    ))
            ],
          ),
        );
      },
    ));
  }
}
