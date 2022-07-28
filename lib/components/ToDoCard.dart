import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:to_dos/screens/ToDoInfoScreen.dart';

class ToDoCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;

  final List<Color> circleColors = [Colors.red, Colors.blue, Colors.green];

  ToDoCard(
      {Key? key,
      required this.index,
      required this.title,
      required this.description})
      : super(key: key);

  Color randomGenerator() {
    return circleColors[Random().nextInt(2)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => print('object'),
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ToDoInfoScreen(
                    id: index,
                    title: title,
                    description: description,
                  ))),
      child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                      width: 5))),
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
          )),
    );
  }
}
