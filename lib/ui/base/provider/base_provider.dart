import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool filterIsOpen = false;

  //setters
  void toggleFilter() {
    filterIsOpen = !filterIsOpen;
    notifyListeners();
  }

}
