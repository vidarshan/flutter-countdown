import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/screens/authentication/ErrorScreen.dart';
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
    late String? email = '';
    late String joined = '';
    UserActions userActions = UserActions();
    userActions.getUser().then((value) => email = value?.email);
    return FutureBuilder(
        future: userActions.getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              return ErrorScreen();
            }
            return snapshot.hasData
                ? Container(
                    color: Color.fromARGB(255, 239, 239, 239),
                    child: Column(children: [
                      CupertinoFormSection.insetGrouped(
                        header: const Text('ACCOUNT INFORMATION'),
                        children: [
                          CupertinoTextFormFieldRow(
                            prefix: const Text('Username'),
                            initialValue: 'Sample User',
                            placeholder: 'Sample User',
                          ),
                          CupertinoTextFormFieldRow(
                            prefix: const Text('Email ID'),
                            initialValue: email,
                          ),
                          CupertinoTextFormFieldRow(
                            prefix: const Text('Last login'),
                            initialValue: '11-08-2022 13:11 PM',
                          ),
                        ],
                      ),
                      CupertinoFormSection.insetGrouped(
                        header: const Text('PREFERENCES'),
                        children: const [
                          CupertinoFormRow(
                            prefix: Text(
                              'Dark mode',
                            ),
                            child:
                                CupertinoSwitch(value: true, onChanged: null),
                          )
                        ],
                      ),
                      CupertinoFormSection.insetGrouped(
                          header: const Text('ACTIONS'),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: CupertinoButton(
                                    color: Colors.black,
                                    onPressed: () => print('object'),
                                    child: const Text(
                                      'Delete Account',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: CupertinoButton(
                                  color: Colors.red,
                                  onPressed: () => print('object'),
                                  child: const Text('Log out')),
                            ),
                          ])
                    ]),
                  )
                : const Text('no data');
          } else {
            return ErrorScreen();
          }
        });
  }
}

// List<Widget>.generate(5, (int index) {
// return CupertinoTextFormFieldRow(
//prefix: const Text('Email'),
//placeholder: 'Enter text',
//initialValue: email,
//validator: (String? value) {
//if (value == null || value.isEmpty) {
//return 'Please enter a value';
//}
//return null;
//},
//);
//}

// Center(
//                     child: Form(
//                       child: CupertinoFormSection.insetGrouped(
//                         header: const Text('ACCOUNT INFORMATION'),
//                         children: [
//                           CupertinoTextFormFieldRow(
//                             prefix: const Text('Username'),
//                             initialValue: 'Sample User',
//                             placeholder: 'Sample User',
//                             enabled: false,
//                           ),
//                           CupertinoTextFormFieldRow(
//                             prefix: const Text('Email ID'),
//                             initialValue: email,
//                             enabled: false,
//                           ),
//                           CupertinoTextFormFieldRow(
//                             prefix: const Text('Last login'),
//                             initialValue: '11-08-2022 13:11 PM',
//                             enabled: false,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )