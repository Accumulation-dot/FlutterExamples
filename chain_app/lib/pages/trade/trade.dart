import 'package:flutter/material.dart';

class Trade with ChangeNotifier {
  int _state = 0;
  int get state => _state;
  void changeState(int state) {
    _state = state;
    notifyListeners();
  }
}
