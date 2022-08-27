import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_dos/models/User.dart';
import 'package:to_dos/state/theme/state.dart';
import 'package:to_dos/state/user/state.dart';
import 'package:uuid/uuid.dart';

class ThemeActions {
  final BuildContext context;
  late ThemeState themeState;
  var uuid = const Uuid();

  ThemeActions({required this.context}) {
    themeState = Provider.of(context, listen: false);
  }

  setTheme(theme) async {
    var setThemePrefs = await SharedPreferences.getInstance();
    setThemePrefs.setString('theme', theme);
    themeState.currentTheme = theme;
    themeState.update();
  }

  Future<String?> getTheme() async {
    var getThemePrefs = await SharedPreferences.getInstance();
    var theme = getThemePrefs.getString('theme');

    themeState.update();
    return theme;
  }
}
