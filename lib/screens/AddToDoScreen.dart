import 'package:flutter/cupertino.dart';

class AddToDoScreen extends StatefulWidget {
  AddToDoScreen({Key? key}) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Text('Text'),
    );
  }
}
