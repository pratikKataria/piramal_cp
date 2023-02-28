import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/today_fu_screen.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_screen.dart';
import 'package:provider/provider.dart';

import 'explore/explore_screen.dart';
import 'home/home_screen.dart';
import 'notificationSc/notification_screen.dart';
import 'upload/upload_screen.dart';

class BottomNavigationBaseScreen extends StatelessWidget {
  final GlobalKey<NotificationScreenState> nGK = GlobalKey<NotificationScreenState>();
  final GlobalKey<HomeScreenState> hGK = GlobalKey<HomeScreenState>();

  BottomNavigationBaseScreen() {
    initState();
  }

  Map<String, Widget> allDestinations;

  void initState() async {
    allDestinations = {
      Screens.kHomeScreen: HomeScreen(key: hGK),
      Screens.kExploreScreen: ExploreScreen(),
      Screens.kUpload: UploadScreen(),
      Screens.kNotificationsScreen: NotificationScreen(key: nGK),
      Screens.kTodayFollowUpScreen: TodayFollowUpScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseProvider>(builder: (_, provider, __) {
      return IndexedStack(
        index: getIndexOfScreen(provider.currentScreen),
        children: allDestinations.values.toList(),
      );
    });
  }

  int getIndexOfScreen(String screen) {
    switch (screen) {
      case Screens.kNotificationsScreen:
        nGK.currentState.updateNotification();
        break;
      case Screens.kHomeScreen:
        hGK?.currentState?.updateHome();
        break;
    }

    if (allDestinations.containsKey(screen)) {
      return allDestinations.values.toList().indexOf(allDestinations[screen]);
    } else {
      return 0;
    }
  }
}
