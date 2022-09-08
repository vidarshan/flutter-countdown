import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/theme/state.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:to_dos/state/user/actions.dart';

class ToDoListScreen extends StatefulWidget {
  ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  ToDoState toDoState = ToDoState();
  UserActions userActions = UserActions();
  var user = '';
  var completed = 'All';

  @override
  void initState() {
    super.initState();
    ToDoActions toDoActions = ToDoActions(context: context);
    UserActions userActions = UserActions();
  }

  void searchToDos(keyword) {
    ToDoActions toDoActions = ToDoActions(context: context);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Query postListRef = FirebaseDatabase.instance
        .ref("todos")
        .orderByChild('userUID')
        .equalTo(auth.currentUser?.uid);
    return CupertinoPageScaffold(
        child: StreamBuilder(
      stream: postListRef.onValue,
      builder: (context, snapshot) {
        List<ToDo> toDoList = [];
        if (snapshot.hasData &&
            snapshot.data != null &&
            (snapshot.data! as DatabaseEvent).snapshot.value != null) {
          final myMessages = Map<dynamic, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>);
          myMessages.forEach((key, value) {
            final toDo = Map<String, dynamic>.from(value);
            if (completed == 'All') {
              toDoList.add(ToDo(
                  id: toDo['id'],
                  name: toDo['title'],
                  description: toDo['description'],
                  completed: toDo['completed'],
                  color: toDo['color'],
                  createdAt: toDo['createdAt'],
                  nodeKey: key,
                  userUID: toDo['userUID']));
            } else if (completed == 'Completed') {
              if (toDo['completed']) {
                toDoList.add(ToDo(
                    id: toDo['id'],
                    name: toDo['title'],
                    description: toDo['description'],
                    completed: toDo['completed'],
                    color: toDo['color'],
                    createdAt: toDo['createdAt'],
                    nodeKey: key,
                    userUID: toDo['userUID']));
              }
            } else if (completed == 'Uncompleted') {
              if (!toDo['completed']) {
                toDoList.add(ToDo(
                    id: toDo['id'],
                    name: toDo['title'],
                    description: toDo['description'],
                    completed: toDo['completed'],
                    color: toDo['color'],
                    createdAt: toDo['createdAt'],
                    nodeKey: key,
                    userUID: toDo['userUID']));
              }
            }
            toDoList.reversed;
          });
          return SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 20, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl(
                      thumbColor: Colors.white,
                      groupValue: completed,
                      onValueChanged: ((value) {
                        if (value == 'All') {
                          setState(() {
                            completed = 'All';
                          });
                        } else if (value == 'Completed') {
                          setState(() {
                            completed = 'Completed';
                          });
                        } else {
                          setState(() {
                            completed = 'Uncompleted';
                          });
                        }
                      }),
                      children: const {
                        'All': Text(
                          'All',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        'Completed': Text(
                          'Completed',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        'Uncompleted': Text(
                          'Uncompleted',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      }),
                ),
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
                        )))
            ],
          ));
        } else {
          return const SafeArea(
            child: Center(
              child: Text(
                'You have no ToDos',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
      },
    ));
  }
}
