import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/components/ToDoNotifcationCard.dart';
import 'package:to_dos/models/ToDoNotification.dart';

class ToDoNotificationsScreen extends StatefulWidget {
  ToDoNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<ToDoNotificationsScreen> createState() =>
      _ToDoNotificationsScreenState();
}

class _ToDoNotificationsScreenState extends State<ToDoNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Query postListRef = FirebaseDatabase.instance
        .ref("notifications")
        .orderByChild('userUID')
        .equalTo(auth.currentUser?.uid);
    return const CupertinoPageScaffold(
        child: Center(
      child: Text('dddd'),
    ));
  }
}
