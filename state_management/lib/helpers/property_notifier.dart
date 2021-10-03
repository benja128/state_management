import 'package:flutter/material.dart';

class PropertyNotifer with ChangeNotifier {
  int _time = 0;
  int get time => _time;
  Map _map = Map<int, int>();
  Map get map => _map;

  void init() {
    Map newMap = Map<int, int>();
    for (int i = 1; i <= 10; i++) {
      newMap[i] = 0;
    }
    _map = newMap;
  }

  set map(Map newMap) {
    _map = newMap;
    notifyListeners();
  }

  set time(int value) {
    _time = value;
    _counter();
    notifyListeners();
  }

  void _counter() {
    for (int i = 1; i <= _map.length; i++) {
      if (time % i == 0) {
        map[i] = map[i] + 1;
        notifyListeners();
      }
    }
  }
}
