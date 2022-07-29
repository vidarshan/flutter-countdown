import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_dos/models/Todo.dart';

class ToDoState with ChangeNotifier {
  List<ToDo> toDoList = [
    // ToDo(name: 'Mail', description: 'Check the mailbox.'),
    // ToDo(name: 'Dinner', description: 'Dinner at 8 PM.'),
    // ToDo(name: 'Dog', description: 'Take the dog out tomorrow morning.'),
    // ToDo(name: 'Grocery', description: 'Buy groceries for the next 2 weeks.'),
    // ToDo(name: 'Clean up', description: 'Clean up the household.'),
    // ToDo(name: 'Mom', description: 'Call mom.'),
    // ToDo(name: 'Lock', description: 'Lock the gate before sleeping.'),
    // ToDo(
    //     name: 'Reservation',
    //     description: 'Arrange a reservation at a restaurant.'),
  ];

  void update() {
    notifyListeners();
  }
}
