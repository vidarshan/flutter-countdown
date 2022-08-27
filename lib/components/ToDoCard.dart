import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:to_dos/screens/ToDoInfoScreen.dart';
import 'package:to_dos/state/theme/state.dart';

class ToDoCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final int createdAt;
  final String nodeKey;

  final List<Color> circleColors = [Colors.red, Colors.blue, Colors.green];

  ToDoCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.completed,
      required this.createdAt,
      required this.nodeKey})
      : super(key: key);

  Color randomGenerator() {
    return circleColors[Random().nextInt(2)];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: ((context, theme, child) => GestureDetector(
            onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ToDoInfoScreen(
                          id: id,
                          title: title,
                          description: description,
                          completed: completed,
                          createdAt: createdAt,
                          nodeKey: nodeKey,
                        ))),
            child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(1.0),
                            width: 5))),
                height: 70,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text((title.toUpperCase()),
                                style: TextStyle(
                                    color: theme.currentTheme == 'dark'
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                description,
                                style: TextStyle(
                                    //Color.fromARGB(255, 156, 156, 156)
                                    fontWeight: FontWeight.w500,
                                    color: theme.currentTheme == 'dark'
                                        ? Color.fromARGB(255, 156, 156, 156)
                                        : Color.fromARGB(255, 156, 156, 156)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                DateFormat('yyyy-MM-dd kk:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        createdAt)),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 63, 139, 239),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )),
          )),
    );
  }
}
