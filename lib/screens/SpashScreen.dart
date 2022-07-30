import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpashScreen extends StatefulWidget {
  SpashScreen({Key? key}) : super(key: key);

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
            child: Container(
      color: Colors.red,
      child: const Text('Loading'),
    )));
  }
}
