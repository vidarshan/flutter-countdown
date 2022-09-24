import 'dart:async';

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

class _ToDoNotificationsScreenState extends State<ToDoNotificationsScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("notifications");
  List<ToDoNotification> toDoList = [];

  Stream getAllGuestbooksSync() {
    final StreamController streamController =
        StreamController<List>.broadcast();
    List<ToDoNotification> notificationsList = [];
    ref.onValue.listen((event) async {
      var dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        final myMessages = Map<dynamic, dynamic>.from(
            (dataSnapshot.value) as Map<dynamic, dynamic>);
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
        streamController.add(toDoList);
      }
    });
    print(streamController.stream);
    return streamController.stream;
  }

  @override
  void initState() {
    super.initState();
    getAllGuestbooksSync();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Query postListRef = FirebaseDatabase.instance
        .ref("notifications")
        .orderByChild('userUID')
        .equalTo(auth.currentUser?.uid);
    print(getAllGuestbooksSync());
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
