import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/models/ToDoNotification.dart';
import 'package:to_dos/screens/AddToDoScreen.dart';
import 'package:to_dos/screens/SearchToDoScreen.dart';
import 'package:to_dos/screens/SettingsScreen.dart';
import 'package:to_dos/screens/ToDoInfoScreen.dart';
import 'package:to_dos/screens/ToDoListScreen.dart';
import 'package:to_dos/screens/ToDoNotificationsScreen.dart';
import 'package:to_dos/screens/authentication/LogInScreen.dart';
import 'package:to_dos/screens/authentication/SignUpScreen.dart';
import 'package:to_dos/state/theme/actions.dart';
import 'package:to_dos/state/theme/state.dart';
import 'package:to_dos/state/toDoNotifications/actions.dart';
import 'package:to_dos/state/toDoNotifications/state.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_dos/state/user/actions.dart';
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
  UserActions useractions = UserActions();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ToDoState()),
          ChangeNotifierProvider(create: (context) => ToDoNotficationsState()),
          ChangeNotifierProvider(
            create: (context) => ThemeState(),
          )
        ],
        child: CupertinoApp(
          theme: CupertinoThemeData(
              textTheme:
                  CupertinoTextThemeData(primaryColor: globals.appAccentColor)),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const MyStatefulWidget();
                } else {
                  return LogInScreen();
                }
              }),
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
  static Map<String, dynamic> toDoNotificationsMap = {};
  final List<Widget> _tabs = [
    ToDoNotificationsScreen(),
    ToDoListScreen(),
    SearchToDoScreen(),
    SettingsScreen()
  ];
  late ThemeActions themeActions = ThemeActions(context: context);
  ToDoState toDoState = ToDoState();
  late ToDoNotificationsActions toDoNotificationsActions =
      ToDoNotificationsActions(context: context);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Query postListRef = FirebaseDatabase.instance
        .ref("notifications")
        .orderByChild('userUID')
        .equalTo(auth.currentUser?.uid);
    return Consumer2<ToDoNotficationsState, ThemeState>(
        builder: ((context, toDoNotifications, theme, child) =>
            CupertinoPageScaffold(
                child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
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
              ),
              child: CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    activeColor: Colors.blue,
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.list_bullet,
                          size: 24,
                          color: Colors.blue,
                        ),
                        label: 'ToDos',
                      ),
                      const BottomNavigationBarItem(
                          icon: Icon(
                            CupertinoIcons.search,
                            color: Colors.blue,
                            size: 24,
                          ),
                          label: 'Search'),
                      BottomNavigationBarItem(
                          icon: StreamBuilder(
                            stream: postListRef.onValue,
                            builder: (context, snapshot) {
                              List<ToDoNotification> toDoList = [];
                              if (snapshot.hasData) {
                                final myMessages = Map<dynamic, dynamic>.from(
                                    (snapshot.data! as DatabaseEvent)
                                        .snapshot
                                        .value as Map<dynamic, dynamic>);
                                myMessages.forEach((key, value) {
                                  final toDo = Map<String, dynamic>.from(value);

                                  toDoList.add(ToDoNotification(
                                      id: toDo['id'],
                                      title: toDo['title'],
                                      description: toDo['description'],
                                      createdAt: toDo['createdAt'],
                                      todoID: toDo['todoID'],
                                      userUID: toDo['userUID'],
                                      nodeKey: key));
                                });
                                return Badge(
                                  animationType: BadgeAnimationType.scale,
                                  badgeContent: Text(
                                    toDoList.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  position:
                                      const BadgePosition(bottom: 4, start: 10),
                                  badgeColor: Color.fromARGB(255, 97, 84, 83),
                                  child: const Icon(
                                    CupertinoIcons.bell,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                );
                              } else {
                                return Badge(
                                  animationType: BadgeAnimationType.scale,
                                  badgeContent: const Text(
                                    '1',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  position:
                                      const BadgePosition(bottom: 4, start: 10),
                                  badgeColor: Colors.green,
                                  child: const Icon(
                                    CupertinoIcons.bell,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                );
                              }
                            },
                          ),
                          label: 'Notifications'),
                      const BottomNavigationBarItem(
                          icon: Icon(
                            CupertinoIcons.settings,
                            color: Colors.blue,
                            size: 24,
                          ),
                          label: 'Settings'),
                    ],
                  ),
                  tabBuilder: (BuildContext context, index) {
                    return _tabs[index];
                  }),
            ))));
  }
}
