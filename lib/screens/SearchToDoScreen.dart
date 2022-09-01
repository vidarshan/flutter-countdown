import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchToDoScreen extends StatefulWidget {
  SearchToDoScreen({Key? key}) : super(key: key);

  @override
  State<SearchToDoScreen> createState() => _SearchToDoScreenState();
}

class _SearchToDoScreenState extends State<SearchToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: CupertinoSearchTextField(
            placeholder: 'Search ToDos',
            style: const TextStyle(color: Colors.grey),
            onChanged: ((value) => print(value))),
      ),
    );
  }
}
