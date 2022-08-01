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
    return const SafeArea(
      child: Text('data'),
    );
  }
}
