import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/state/theme/actions.dart';
import 'package:to_dos/state/theme/state.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/constants/globals.dart' as globals;
import 'package:to_dos/state/user/actions.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeActions themeActions = ThemeActions(context: context);
    UserActions userActions = UserActions();

    return Consumer<ThemeState>(
      builder: (context, theme, child) => CupertinoPageScaffold(
        child: Container(
          child: Center(
            child: (Form(
              child: CupertinoFormSection.insetGrouped(
                  decoration: BoxDecoration(
                      color: theme.currentTheme == 'dark'
                          ? globals.darkThemeColor
                          : globals.lightThemeColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  backgroundColor: theme.currentTheme == 'dark'
                      ? globals.greyDarkBackgroundColor
                      : globals.greyLightBackgroundColor,
                  header: Text(
                    'Theme'.toUpperCase(),
                    style: TextStyle(
                        color: theme.currentTheme == 'dark'
                            ? globals.darkThemeTextColor
                            : globals.lightThemeTextColor),
                  ),
                  children: [
                    CupertinoFormRow(
                        prefix: Text(
                          'Dark mode',
                          style: TextStyle(
                              color: theme.currentTheme == 'dark'
                                  ? globals.darkThemeTextColor
                                  : globals.lightThemeTextColor),
                        ),
                        child: CupertinoSwitch(
                            value: theme.currentTheme == 'dark' ? true : false,
                            onChanged: (value) => themeActions.setTheme(
                                theme.currentTheme == 'dark'
                                    ? 'light'
                                    : 'dark'))),
                    CupertinoFormRow(
                      child: CupertinoButton(
                        child: Text('Log out'),
                        color: Colors.red,
                        onPressed: () => userActions.signOut().then((value) =>
                            userActions.getUser().then((value) => value == null
                                ? Navigator.pushReplacementNamed(
                                    context, '/login')
                                : Navigator.pushReplacementNamed(
                                    context, '/'))),
                      ),
                    )
                  ]),
            )),
          ),
        ),
      ),
    );
  }
}
