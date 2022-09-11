import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/models/User.dart';
import 'package:to_dos/state/todo/actions.dart';
import 'package:to_dos/state/todo/state.dart';
import 'package:to_dos/state/user/actions.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserActions userActions = UserActions();
  String username = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    () => Navigator.pushNamed(context, '/');
  }

  void registerUser() async {
    UserActions.mailRegister(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Navigator.pushReplacementNamed(context, '/');
            return const CupertinoPageScaffold(
                child: SafeArea(
                    child: Center(
              child: CupertinoActivityIndicator(
                radius: 30.0,
                animating: true,
                color: Colors.amber,
              ),
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
                        'Create new account',
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
                        controller: _usernameController,
                        placeholder: 'Your username',
                        onChanged: (value) => username = value,
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
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 28),
                    child: SizedBox(
                      height: 40,
                      child: CupertinoTextField(
                        controller: _passwordController,
                        placeholder: 'Your password',
                        onChanged: (value) => password = value,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CupertinoButton.filled(
                        child: const Text('Sign up'),
                        onPressed: () =>
                            UserActions.mailRegister(email, password),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CupertinoButton(
                        child: const Text('Have an account?'),
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
