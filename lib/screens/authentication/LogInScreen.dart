import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_dos/state/user/actions.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = '';
  String password = '';
  UserActions userActions = UserActions();

  void showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Incorrect Credentials'),
        content: const Text('Try again with correct credentials.'),
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
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: SizedBox(
                height: 40,
                child: CupertinoTextField(
                  controller: _emailController,
                  placeholder: 'Your email',
                  onChanged: (value) => email = value,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: SizedBox(
                height: 40,
                child: CupertinoTextField(
                  controller: _passwordController,
                  obscureText: true,
                  placeholder: 'Your password',
                  onChanged: (value) => password = value,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton.filled(
                  child: const Text('Log in'),
                  onPressed: () =>
                      userActions.loginUser(email, password).then((value) => {
                            if (value.user.uid != null)
                              {Navigator.pushReplacementNamed(context, '/')}
                          })),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: SizedBox(
              width: double.maxFinite,
              child: CupertinoButton(
                child: const Text('New user?'),
                onPressed: () => Navigator.pushNamed(context, '/signup'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
