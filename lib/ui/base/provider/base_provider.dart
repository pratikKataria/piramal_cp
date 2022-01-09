import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Screens.dart';

class BaseProvider extends ChangeNotifier {
  bool filterIsOpen = false;
  bool drawerIsOpen = false;
  String currentScreen = Screens.kHomeScreen;
  GlobalKey<ScaffoldState> drawerKey;

  //Notifiers
  void toggleFilter() {
    filterIsOpen = !filterIsOpen;
    notifyListeners();
  }

  void toggleDrawer() {
    drawerIsOpen = !drawerIsOpen;
    notifyListeners();
  }

  void setBottomNavScreen(String incomingScreen) {
    currentScreen = incomingScreen;
    notifyListeners();
  }
}
