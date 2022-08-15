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
    toDoActions.readFromSharedPreferences();
  }

  void searchToDos(keyword) {
    ToDoActions toDoActions = ToDoActions(context: context);
    toDoActions.searchToDos(keyword);
  }

  // postListRef.onValue.listen((DatabaseEvent event) {
  //   final data = event.snapshot.value;
  //   print(data);
  // });
  @override
  Widget build(BuildContext context) {
    DatabaseReference postListRef = FirebaseDatabase.instance.ref("todos");
    return StreamBuilder(
      stream: postListRef.onValue,
      builder: (context, snapshot) {
        List<ToDo> messageList = [];
        if (snapshot.hasData &&
            snapshot.data != null &&
            (snapshot.data! as DatabaseEvent).snapshot.value != null) {
          final myMessages = Map<dynamic, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>); //typecasting
          myMessages.forEach((key, value) {
            final currentMessage = Map<String, dynamic>.from(value);
            print(currentMessage);
            messageList.add(ToDo(
              id: '1',
              name: currentMessage['title'],
              description: currentMessage['description'],
              completed: currentMessage['completed'],
              createdAt: DateTime.fromMillisecondsSinceEpoch(
                  currentMessage['createdAt']),
            ));
          }); //created a class called message and added all messages in a List of class message
          return ListView.builder(
            reverse: true,
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              print(messageList[index].name);
              return Text(messageList[index].name);
            },
          );
        } else {
          return const Center(
            child: Text(
              'Say Hi...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w400),
            ),
          );
        }
      },
    );
  }
}
