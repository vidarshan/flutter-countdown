import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_dos/models/ToDoNotification.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/toDoNotifications/state.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:uuid/uuid.dart';

class ToDoNotificationsActions {
  final BuildContext context;
  late ToDoNotficationsState toDoNotifications;

  ToDoNotificationsActions({required this.context}) {
    toDoNotifications = Provider.of(context, listen: false);
  }

  void setToDoNotificationCount(newCount) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      toDoNotifications.notificationsCount = newCount;
      toDoNotifications.update();
    });
  }
}
