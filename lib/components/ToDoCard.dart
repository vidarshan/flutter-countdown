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
            child: SizedBox(
              width: double.maxFinite,
              child: Container(
                  margin: const EdgeInsets.only(top: 22, left: 16, right: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 185, 185, 185)
                                .withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 0.4))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        CupertinoIcons.circle_fill,
                                        color: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(1.0),
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text((title.toUpperCase()),
                                            style: TextStyle(
                                                color:
                                                    theme.currentTheme == 'dark'
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            description,
                                            style: const TextStyle(
                                                //Color.fromARGB(255, 156, 156, 156)
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            DateFormat('yyyy-MM-dd kk:mm a')
                                                .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        createdAt)),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
            ),
          )),
    );
  }
}
