import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/models/DynamicColor.dart';
import 'package:to_dos/models/Todo.dart';
import 'package:to_dos/state/theme/state.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_dos/constants/globals.dart' as globals;
import 'package:to_dos/helpers/ToDo.dart' as toDoHelpers;

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({Key? key}) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final toDoListRef = FirebaseDatabase.instance.ref('todos');
  late DatabaseReference newToDoRef;
  late ToDoActions toDoActions = ToDoActions(context: context);
  String toDoName = '';
  String toDoDescription = '';
  bool toDoCompleted = false;
  bool disableButton = false;
  String circleColor = 'Red';
  final double _kItemExtent = 32.0;
  final List<String> _fruitNames = <String>[
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Black',
    'Purple',
  ];

  final List<DynamicColor> circleColors = [
    DynamicColor(name: 'Red', color: Colors.red),
    DynamicColor(name: 'Blue', color: Colors.blue),
    DynamicColor(name: 'Green', color: Colors.green),
    DynamicColor(name: 'Purple', color: Colors.purple),
    DynamicColor(name: 'Black', color: Colors.black),
    DynamicColor(name: 'Yellow', color: Colors.yellow),
  ];

  @override
  void initState() {
    super.initState();
  }

  void addToDo() {
    toDoHelpers.createNewToDo(
        toDoName, toDoDescription, toDoCompleted, circleColor);
    Navigator.pop(context);
  }

  void setAddToDoFormFieldValues(field, value) {
    if (field == 'name') {
      toDoName = value;
      ;
    } else {
      toDoDescription = value;
    }
  }

  void showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Missing Data'),
        content: const Text('Please fill all the fields.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: false,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _selectedFruit = 0;

    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 216,
                padding: const EdgeInsets.only(top: 6.0),
                // The Bottom margin is provided to align the popup above the system navigation bar.
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // Provide a background color for the popup.
                color: CupertinoColors.systemBackground.resolveFrom(context),
                // Use a SafeArea widget to avoid system overlaps.
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ));
    }

    return Consumer<ThemeState>(
      builder: ((context, theme, child) => CupertinoPageScaffold(
            backgroundColor: theme.currentTheme == 'dark'
                ? globals.darkThemeColor
                : globals.lightThemeColor,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: theme.currentTheme == 'dark'
                  ? globals.darkThemeColor
                  : globals.lightThemeColor,
              previousPageTitle: 'ToDos',
            ),
            child: Container(
              color: theme.currentTheme == 'dark'
                  ? globals.greyDarkBackgroundColor
                  : globals.greyLightBackgroundColor,
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      CupertinoFormSection.insetGrouped(
                          decoration: BoxDecoration(
                              color: theme.currentTheme == 'dark'
                                  ? globals.darkThemeColor
                                  : globals.lightThemeColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          backgroundColor: theme.currentTheme == 'dark'
                              ? globals.greyDarkBackgroundColor
                              : globals.greyLightBackgroundColor,
                          header: Text(
                            'ToDo Info'.toUpperCase(),
                            style: TextStyle(
                                color: theme.currentTheme == 'dark'
                                    ? globals.darkThemeTextColor
                                    : globals.lightThemeTextColor),
                          ),
                          children: [
                            CupertinoTextFormFieldRow(
                              validator: (String? value) {
                                disableButton = true;
                                return (value == '')
                                    ? 'Title cannot be empty'
                                    : null;
                              },
                              placeholderStyle: TextStyle(
                                  color: theme.currentTheme == 'dark'
                                      ? globals.darkPlaceHolderColor
                                      : globals.lightPlaceHolderColor),
                              prefix: const Text(
                                'Title',
                              ),
                              placeholder: 'Enter Title',
                              onChanged: (value) => {toDoName = value},
                            ),
                            CupertinoTextFormFieldRow(
                              validator: (String? value) {
                                return (value == '')
                                    ? 'Description cannot be empty'
                                    : null;
                              },
                              placeholderStyle: TextStyle(
                                  color: theme.currentTheme == 'dark'
                                      ? globals.darkPlaceHolderColor
                                      : globals.lightPlaceHolderColor),
                              prefix: Text(
                                'Description',
                                style: TextStyle(
                                    color: theme.currentTheme == 'dark'
                                        ? globals.darkThemeTextColor
                                        : globals.lightThemeTextColor),
                              ),
                              placeholder: 'Enter Description',
                              onChanged: (value) => {toDoDescription = value},
                            ),
                            CupertinoFormRow(
                                child: Row(
                              children: [
                                const Text('Color'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () => _showDialog(
                                      CupertinoPicker(
                                        magnification: 1.22,
                                        squeeze: 1.2,
                                        useMagnifier: true,
                                        itemExtent: _kItemExtent,
                                        onSelectedItemChanged:
                                            (int selectedItem) {
                                          setState(() {
                                            _selectedFruit = selectedItem;
                                            circleColor =
                                                _fruitNames[_selectedFruit];
                                          });
                                        },
                                        children: List<Widget>.generate(
                                            _fruitNames.length, (int index) {
                                          return Center(
                                            child: Text(
                                              _fruitNames[index],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.circle_fill,
                                      color: circleColors
                                          .firstWhere((element) =>
                                              element.name == circleColor)
                                          .color,
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ]),
                      CupertinoFormSection.insetGrouped(
                          decoration: BoxDecoration(
                              color: theme.currentTheme == 'dark'
                                  ? globals.darkThemeColor
                                  : globals.lightThemeColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          backgroundColor: theme.currentTheme == 'dark'
                              ? globals.greyDarkBackgroundColor
                              : globals.greyLightBackgroundColor,
                          header: Text(
                            'ToDo Status'.toUpperCase(),
                            style: TextStyle(
                                color: theme.currentTheme == 'dark'
                                    ? globals.darkThemeTextColor
                                    : globals.lightThemeTextColor),
                          ),
                          children: [
                            CupertinoFormRow(
                                prefix: Text(
                                  'Complete ToDo',
                                  style: TextStyle(
                                      color: theme.currentTheme == 'dark'
                                          ? globals.darkThemeTextColor
                                          : globals.lightThemeTextColor),
                                ),
                                child: CupertinoSwitch(
                                    value: toDoCompleted,
                                    onChanged: (value) => setState(() {
                                          toDoCompleted = value;
                                        }))),
                          ]),
                      CupertinoFormSection.insetGrouped(
                        backgroundColor: theme.currentTheme == 'dark'
                            ? globals.greyDarkBackgroundColor
                            : globals.greyLightBackgroundColor,
                        children: [
                          Container(
                            color: theme.currentTheme == 'dark'
                                ? globals.greyDarkBackgroundColor
                                : globals.greyLightBackgroundColor,
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: CupertinoButton(
                                  color: globals.appAccentColor,
                                  onPressed: () =>
                                      toDoName == '' || toDoDescription == ''
                                          ? showAlertDialog(context)
                                          : addToDo(),
                                  child: const Text('Add ToDo')),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          )),
    );
  }
}
