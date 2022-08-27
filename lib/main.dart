import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/screens/AddToDoScreen.dart';
import 'package:to_dos/screens/SettingsScreen.dart';
import 'package:to_dos/screens/ToDoInfoScreen.dart';
import 'package:to_dos/screens/ToDoListScreen.dart';
import 'package:to_dos/screens/authentication/LogInScreen.dart';
import 'package:to_dos/screens/authentication/SignUpScreen.dart';
import 'package:to_dos/state/theme/actions.dart';
import 'package:to_dos/state/theme/state.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:to_dos/state/user/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:to_dos/constants/globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeState themeState = ThemeState();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ToDoState()),
          ChangeNotifierProvider(create: (context) => UserState()),
          ChangeNotifierProvider(
            create: (context) => ThemeState(),
          )
        ],
        child: CupertinoApp(
          theme: CupertinoThemeData(
              textTheme:
                  CupertinoTextThemeData(primaryColor: globals.appAccentColor)),
          debugShowCheckedModeBanner: false,
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
                    builder: (_) => const ToDoInfoScreen(
                          id: '',
                          title: '',
                          description: '',
                          completed: false,
                          createdAt: 0,
                          nodeKey: '',
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
  final List<Widget> _tabs = [
    ToDoListScreen(),
    const AddToDoScreen(),
    SettingsScreen()
  ];
  late ThemeActions themeActions = ThemeActions(context: context);
  ToDoState toDoState = ToDoState();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ToDoState, ThemeState>(
      builder: ((context, toDos, theme, child) => CupertinoPageScaffold(
              child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor:
                  theme.currentTheme == 'dark' ? Colors.black : Colors.white,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pushNamed(context, '/add'),
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.blue,
                ),
              ),
              middle: const Text(
                'ToDos',
                style: TextStyle(color: Colors.blue),
              ),
              leading: const Icon(
                CupertinoIcons.person_fill,
                color: Colors.blue,
                size: 24,
              ),
            ),
            child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  activeColor: Colors.blue,
                  backgroundColor: CupertinoColors.quaternarySystemFill,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.square_list_fill,
                        size: 24,
                        color: Colors.blue,
                      ),
                      label: 'ToDos',
                    ),
                    BottomNavigationBarItem(
                        icon: Badge(
                          animationType: BadgeAnimationType.fade,
                          badgeContent: Text(
                            toDos.notificationCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          position: const BadgePosition(bottom: 4, start: 10),
                          badgeColor: globals.notificationBadgeColor,
                          child: const Icon(
                            CupertinoIcons.bell_fill,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                        label: 'Notifications'),
                    const BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.settings,
                          color: Colors.blue,
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
