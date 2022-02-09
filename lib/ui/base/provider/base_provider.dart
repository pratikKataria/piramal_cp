import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Screens.dart';

class BaseProvider extends ChangeNotifier {
  final bool isLogin;
  BaseProvider(this.isLogin);

  bool filterIsOpen = false;
  bool _drawerIsOpen = false;
  bool showAppbarAndBottomNavigation = true;
  String currentScreen = Screens.kHomeScreen;

  GlobalKey<ScaffoldState> drawerKey;

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
