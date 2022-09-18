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

  void loginUser() {
    userActions.loginUser(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, '/');
            });
            return const CupertinoPageScaffold(
                child: SafeArea(
                    child: Center(
              child: CupertinoActivityIndicator(radius: 5.0, animating: true),
            )));
          } else {
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 28),
                    child: SizedBox(
                        height: 40,
                        child: CupertinoTextField(
                          controller: _emailController,
                          placeholder: 'Your email',
                          onChanged: (value) => email = value,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 28),
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
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: SizedBox(
                        width: double.maxFinite,
                        child: CupertinoButton.filled(
                            child: const Text('Log in'),
                            onPressed: () => loginUser())),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CupertinoButton(
                        child: const Text('New user?'),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                      ),
                    ),
                  ),
                ],
              ),
            ));
          }
        });
  }
}
