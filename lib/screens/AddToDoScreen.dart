import 'package:flutter/cupertino.dart';

class AddToDoScreen extends StatefulWidget {
  AddToDoScreen({Key? key}) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Add')),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                height: 40,
                child: CupertinoTextField(
                  placeholder: 'Todo Title',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  child: CupertinoTextField(
                    placeholder: 'Todo Description',
                  ),
                ),
              ),
              CupertinoButton(onPressed: null, child: Text('Add Todo'))
            ]),
      ),
    );
  }
}
