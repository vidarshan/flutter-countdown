import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/todo/actions.dart';

class AddToDoForm extends StatefulWidget {
  const AddToDoForm({Key? key}) : super(key: key);

  @override
  State<AddToDoForm> createState() => _AddToDoFormState();
}

class _AddToDoFormState extends State<AddToDoForm> {
  final _formKey = GlobalKey<FormState>();
  late ToDoActions toDoActions = ToDoActions(context: context);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          children: List<Widget>.generate(5, (int index) {
        return CupertinoTextFormFieldRow(
          prefix: const Text('Enter text'),
          placeholder: 'Enter text',
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        );
      })),
    );
  }
}
