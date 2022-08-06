import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/screens/AddToDoScreen.dart';
import 'package:to_dos/screens/SearchToDoScreen.dart';
import 'package:to_dos/screens/SettingsScreen.dart';
import 'package:to_dos/screens/ToDoInfoScreen.dart';
import 'package:to_dos/screens/ToDoListScreen.dart';
import 'package:to_dos/screens/ToDoNotificationsScreen.dart';
import 'package:to_dos/screens/authentication/LogInScreen.dart';
import 'package:to_dos/screens/authentication/SignUpScreen.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:to_dos/state/user/state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ToDoState()),
          ChangeNotifierProvider(create: (context) => UserState()),
        ],
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          title: _title,
          home: const MyStatefulWidget(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return CupertinoPageRoute(
                    builder: (_) => ToDoListScreen(), settings: settings);
              case '/add':
                return CupertinoPageRoute(
                    builder: (_) => const AddToDoScreen(), settings: settings);
              case '/info':
                return CupertinoPageRoute(
                    builder: (_) => ToDoInfoScreen(
                          id: '',
                          title: '',
                          description: '',
                          completed: false,
                          createdAt: DateTime.now(),
                        ),
                    settings: settings);
              case '/signup':
                return CupertinoPageRoute(
                    builder: (_) => SignUpScreen(), settings: settings);
              case '/login':
                return CupertinoPageRoute(
                    builder: (_) => LogInScreen(), settings: settings);
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
  final List<Widget> _tabs = [ToDoListScreen(), ToDoNotificationsScreen()];
  late ToDoActions toDoActions = ToDoActions(context: context);
  ToDoState toDoState = ToDoState();

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoState>(
      builder: ((context, toDos, child) => CupertinoPageScaffold(
              child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Colors.white,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pushNamed(context, '/add'),
                child: const Icon(CupertinoIcons.add),
              ),
              middle: const Text('ToDos'),
            ),
            child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  backgroundColor: Colors.white,
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.list_dash,
                          size: 24,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Badge(
                          badgeContent: Text(
                            toDos.notificationCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          badgeColor: Colors.red,
                          child: const Icon(
                            CupertinoIcons.bell,
                            size: 24,
                          ),
                        ),
                        label: 'Notifications'),
                  ],
                ),
                tabBuilder: (BuildContext context, index) {
                  return _tabs[index];
                }),
          ))),
    );
  }
}

class SettingsTab extends StatefulWidget {
  SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoButton(
      onPressed: () => Navigator.pushNamed(context, '/signup'),
      child: CupertinoButton(
        child: Text('dd'),
        onPressed: () => print('dd'),
      ),
    ));
  }
}
