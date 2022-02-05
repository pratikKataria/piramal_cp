import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/today_fu_screen.dart';
import 'package:provider/provider.dart';

import 'explore/explore_screen.dart';
import 'home/home_screen.dart';
import 'notificationSc/notification_screen.dart';

class HomeBottomNavigationBaseScreen extends StatelessWidget {
  HomeBottomNavigationBaseScreen() {
    initState();
  }

  Map<String, Widget> allDestinations;

  void initState() async {
    allDestinations = {
      Screens.kHomeScreen: HomeScreen(),
      Screens.kExploreScreen: ExploreScreen(),
      Screens.kNotificationsScreen: NotificationScreen(),
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
    if (allDestinations.containsKey(screen)) {
      return allDestinations.values.toList().indexOf(allDestinations[screen]);
    } else {
      return 0;
    }
  }
}
