import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/utils/navigator_gk.dart';
import 'package:provider/provider.dart';

class PersistentBottomNavigation extends StatelessWidget {
  const PersistentBottomNavigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomNavigationButton(Images.kIconHome, "Home", () {}, context),
          buildBottomNavigationButton(Images.kIconExplore, "Explore", () {}, context),
          buildBottomNavigationButton(Images.kIconTodayFollowup, "Today's SV", () {}, context),
          buildBottomNavigationButton(Images.kIconNotification, "Notifications", () {}, context),
          // buildBottomNavigationButton(Images.kIconLeaderboard, "Leaderboard", () {}),
        ],
      ),
    );
  }

  Consumer buildBottomNavigationButton(String icon, String text, Function() onTap, BuildContext context) {
    return Consumer<BaseProvider>(
      builder: (_, provider, __) {
        return InkWell(
          onTap: () {
            provider.setBottomNavScreen(text);
            navigateToFirstRoute();
            onTap();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 20.0,
                height: 20.0,
                color: provider.currentScreen == text ? AppColors.colorPrimary : AppColors.colorSecondary,
              ),
              verticalSpace(10.0),
              Text(
                "$text",
                style: provider.currentScreen == text ? textStylePrimary12px500w : textStyle12px500w,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToFirstRoute() {
    navigatorGk.currentState.popUntil((route) => route.isFirst);
  }
}
