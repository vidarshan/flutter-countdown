import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/state/todo/actions.dart';

class SpashScreen extends StatefulWidget {
  SpashScreen({Key? key}) : super(key: key);

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  Widget build(BuildContext context) {
    void naviagteToHome() {
      Navigator.pushNamed(context, '/home');
    }

    ToDoActions td = ToDoActions(context: context);
    td.readFromSharedPreferences();

    return CupertinoPageScaffold(
        child: Center(
            child: Container(
                color: Colors.red,
                child: CupertinoButton(
                  onPressed: naviagteToHome,
                  child: const Text('press'),
                ))));
  }
}
