import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_dos/helpers/ToDo.dart' as toDoHelpers;

class ToDoNotificationCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String todoID;
  final String userID;
  final int createdAt;
  final String nodeKey;

  const ToDoNotificationCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.todoID,
      required this.userID,
      required this.createdAt,
      required this.nodeKey})
      : super(key: key);

  void deleteToDo(nodeKey) {
    toDoHelpers.deleteNotification(nodeKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromARGB(255, 185, 185, 185).withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 0.4))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: 240.0,
                      child: Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd kk:mm a')
                        .format(DateTime.fromMillisecondsSinceEpoch(createdAt)),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const Spacer(),
              CupertinoButton(
                  color: const Color.fromARGB(0, 0, 0, 0),
                  padding: const EdgeInsets.only(top: 0),
                  child: const Icon(
                    CupertinoIcons.multiply,
                    color: Colors.red,
                  ),
                  onPressed: () => deleteToDo(nodeKey)),
            ],
          ),
        ],
      ),
    );
  }
}
