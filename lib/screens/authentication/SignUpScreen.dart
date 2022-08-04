import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:to_dos/state/user/actions.dart';
import 'package:to_dos/state/user/state.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserState userState = UserState();
  late UserActions userActions = UserActions(context: context);
  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    () => Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 40),
              child: Text(
                'Create new account',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: CupertinoTextField(
              placeholder: 'Your username',
              onChanged: (value) => username = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: CupertinoTextField(
              placeholder: 'Your password',
              onChanged: (value) => password = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton.filled(
                child: const Text('Create account'),
                onPressed: () => userActions.register(username, password),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton(
                child: const Text('Have an account?'),
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
