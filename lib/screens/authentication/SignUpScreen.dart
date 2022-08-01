import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: CupertinoTextField(
              placeholder: 'Your name',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: CupertinoTextField(
              placeholder: 'Your password',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton.filled(
                child: const Text('Create account'),
                onPressed: () => Navigator.pop(context),
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
