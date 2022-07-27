import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_dos/state/counter/state.dart';

class CounterActions {
  final BuildContext context;
  late CounterState counter;

  CounterActions({required this.context}) {
    counter = Provider.of(context, listen: false);
  }

  void increment() {
    counter.counter++;
    counter.update();
  }
}
