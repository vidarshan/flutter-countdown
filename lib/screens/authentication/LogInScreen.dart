import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                'Login to your account',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: CupertinoTextField(
              placeholder: 'Your username',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: CupertinoTextField(
              obscureText: true,
              placeholder: 'Your password',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton.filled(
                child: const Text('Log in'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton(
                child: const Text('New user?'),
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
