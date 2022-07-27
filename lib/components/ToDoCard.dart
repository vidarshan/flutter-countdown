import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  final String title;
  final String description;

  const ToDoCard({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 10),
        decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.red, width: 5))),
        height: 50,
        child: Row(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((title), style: const TextStyle(fontSize: 20)),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
