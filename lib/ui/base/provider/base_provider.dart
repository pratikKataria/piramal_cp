import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool filterIsOpen = false;
  bool drawerIsOpen = false;


  //Notifiers
  void toggleFilter() {
    filterIsOpen = !filterIsOpen;
    notifyListeners();
  }

  void toggleDrawer() {
    drawerIsOpen = !drawerIsOpen;
    notifyListeners();
  }

}
