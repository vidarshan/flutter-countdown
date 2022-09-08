import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/components/ToDoNotifcationCard.dart';
import 'package:to_dos/models/ToDoNotification.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/theme/actions.dart';
import 'package:to_dos/state/todo/actions.dart';

class ToDoNotificationsScreen extends StatefulWidget {
  ToDoNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<ToDoNotificationsScreen> createState() =>
      _ToDoNotificationsScreenState();
}

void clearAll() {
  print('object');
}

class _ToDoNotificationsScreenState extends State<ToDoNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Query postListRef = FirebaseDatabase.instance
        .ref("notifications")
        .orderByChild('userUID')
        .equalTo(auth.currentUser?.uid);
    return CupertinoPageScaffold(
        child: StreamBuilder(
      stream: postListRef.onValue,
      builder: (context, snapshot) {
        List<ToDoNotification> toDoList = [];
        if (snapshot.hasData &&
            snapshot.data != null &&
            (snapshot.data! as DatabaseEvent).snapshot.value != null) {
          final myMessages = Map<dynamic, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>);
          myMessages.forEach((key, value) {
            final toDo = Map<String, dynamic>.from(value);

            toDoList.add(ToDoNotification(
                id: toDo['id'],
                title: toDo['title'],
                description: toDo['description'],
                createdAt: toDo['createdAt'],
                todoID: toDo['todoID'],
                userUID: toDo['userUID'],
                nodeKey: key));
          });
          return SafeArea(
              child: Column(
            children: [
              // const Padding(
              //   padding:
              //       EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 0),
              //   child: SizedBox(
              //     width: double.maxFinite,
              //     child: CupertinoButton(
              //         onPressed: clearAll,
              //         child: Text(
              //           'Clear all',
              //         )),
              //   ),
              // ),
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
                            return ToDoNotificationCard(
                              id: toDoList[index].id,
                              title: toDoList[index].title,
                              description: toDoList[index].description,
                              createdAt: toDoList[index].createdAt,
                              todoID: toDoList[index].todoID,
                              userID: toDoList[index].userUID,
                              nodeKey: toDoList[index].nodeKey,
                            );
                          },
                        )))
            ],
          ));
        } else {
          return const CupertinoPageScaffold(
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
