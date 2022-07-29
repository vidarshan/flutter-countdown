import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/state/todo/state.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoState>(
        builder: (context, toDos, child) => Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                          child: ListView.builder(
                              itemCount: toDos.toDoList.length,
                              itemBuilder: ((context, index) => Row(
                                    children: [
                                      Expanded(
                                          child: ToDoCard(
                                        id: toDos.toDoList[index].id,
                                        title: toDos.toDoList[index].name,
                                        description:
                                            toDos.toDoList[index].description,
                                        createdAt:
                                            toDos.toDoList[index].createdAt,
                                      ))
                                    ],
                                  )))),
                    )
                  ]),
            ));
  }
}
