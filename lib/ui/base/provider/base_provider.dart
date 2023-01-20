import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/dataStruct/stack.dart';
import 'package:piramal_channel_partner/res/Screens.dart';

class BaseProvider extends ChangeNotifier {
  bool isLogin;

  BaseProvider(bool isLogin) {
    this.isLogin = isLogin;
    showAppbarAndBottomNavigation = isLogin;
  }

  bool filterIsOpen = false;
  bool _drawerIsOpen = false;
  bool showAppbarAndBottomNavigation = false;
  String currentScreen = Screens.kHomeScreen;

  GlobalKey<ScaffoldState> drawerKey;
  StackSetDSA<String> screenStack = StackSetDSA<String>();

  //getter
  get drawerStatus => _drawerIsOpen;

  //Notifiers
  void toggleFilter() {
    filterIsOpen = !filterIsOpen;
    notifyListeners();
  }

  void openDrawer() {
    _drawerIsOpen = true;
    drawerKey.currentState.openDrawer();
    notifyListeners();
  }

  void closeDrawer() {
    _drawerIsOpen = false;
    drawerKey.currentState.openEndDrawer();
    notifyListeners();
  }

  void setBottomNavScreen(String incomingScreen) {
    currentScreen = incomingScreen;
    notifyListeners();
  }

  void hideToolTip() {
    showAppbarAndBottomNavigation = false;
    notifyListeners();
  }

  void showToolTip() {
    showAppbarAndBottomNavigation = true;
    notifyListeners();
  }
}
