import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';

class ToDoListScreen extends StatefulWidget {
  ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  @override
  void initState() {
    super.initState();
    ToDoActions td = ToDoActions(context: context);
    td.readFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoState>(
        builder: (context, toDos, child) => Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                          child: toDos.toDoList.isEmpty
                              ? const Text(
                                  'You have no ToDos',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : ListView.builder(
                                  itemCount: toDos.toDoList.length,
                                  itemBuilder: ((context, index) => Row(
                                        children: [
                                          Expanded(
                                              child: ToDoCard(
                                            id: toDos.toDoList[index].id,
                                            title: toDos.toDoList[index].name,
                                            description: toDos
                                                .toDoList[index].description,
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

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ToDoState>(
//         builder: (context, toDos, child) => Center(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Expanded(
//                       child: Center(
//                           child: ListView.builder(
//                               itemCount: toDos.toDoList.length,
//                               itemBuilder: ((context, index) => Row(
//                                     children: [
//                                       Expanded(
//                                           child: ToDoCard(
//                                         id: toDos.toDoList[index].id,
//                                         title: toDos.toDoList[index].name,
//                                         description:
//                                             toDos.toDoList[index].description,
//                                         createdAt:
//                                             toDos.toDoList[index].createdAt,
//                                       ))
//                                     ],
//                                   )))),
//                     )
//                   ]),
//             ));
//   }
// }
