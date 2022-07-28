import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/components/ToDoCard.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/screens/AddToDoScreen.dart';
import 'package:to_dos/screens/ToDoInfoScreen.dart';
import 'package:to_dos/screens/ToDoListScreen.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => ToDoState())],
        child: CupertinoApp(
          title: _title,
          home: const MyStatefulWidget(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return CupertinoPageRoute(
                    builder: (_) => const ToDoListScreen(), settings: settings);
              case '/add':
                return CupertinoPageRoute(
                    builder: (_) => const AddToDoScreen(), settings: settings);
              case '/info':
                return CupertinoPageRoute(
                    builder: (_) =>
                        const ToDoInfoScreen(id: 0, title: '', description: ''),
                    settings: settings);
            }
          },
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Widget> _tabs = [const ToDoListScreen(), const SettingTab()];
  late ToDoActions toDoActions = ToDoActions(context: context);

  void addToDo() {
    ToDo newTodo = ToDo(name: 'Buy Milk', description: 'Buy 4L of milk');
    toDoActions.addToDo(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoState>(
      builder: ((context, toDos, child) => CupertinoPageScaffold(
              child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('ToDos'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pushNamed(context, '/add'),
                child: const Icon(CupertinoIcons.add),
              ),
            ),
            child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.list_dash,
                          size: 24,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.settings,
                          size: 24,
                        ),
                        label: 'Settings')
                  ],
                ),
                tabBuilder: (BuildContext context, index) {
                  return _tabs[index];
                }),
          ))),
    );
  }
}

class SettingTab extends StatelessWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoButton(onPressed: null, child: Text('Press')),
    );
  }
}
