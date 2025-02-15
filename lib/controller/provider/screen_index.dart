import 'package:flutter/material.dart';

class ScreenIndexController extends ChangeNotifier {
  int _index = 0;

  int get value => _index;

  set value(int value) {
    _index = value;
    notifyListeners();
  }
}
