import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/controller/bottom_navigation_controller.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/tour_keys_bottom_navigation.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/utils/navigator_gk.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


class PersistentBottomNavigation extends StatelessWidget {
  PersistentBottomNavigation();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.white,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomNavigationButton(Images.kIconHome, "Home", () {}, context, homeBtnKey),
          buildBottomNavigationButton(Assets.imagesIcQrCode, Screens.kQrCodeScannerScreen, () {}, context, null),
          buildBottomNavigationButton(Images.kIconUpload, Screens.kUpload, () {}, context, uploadBtnKey),
          buildBottomNavigationButton(Images.kIconTodayFollowup, Screens.kTodayFollowUpScreen, () {}, context, todayFuBtnKey),
          buildBottomNavigationButton(Images.kIconNotification, "Notifications", () {}, context, notificationBtnKey),
          // buildBottomNavigationButton(Images.kIconLeaderboard, "Leaderboard", () {}),
        ],
      ),
    );
  }

  Consumer buildBottomNavigationButton(String icon, String text, Function() onTap, BuildContext context, GlobalKey key) {
    return Consumer<BaseProvider>(
      builder: (_, provider, __) {
        return InkWell(
          key: key,
          onTap: () {

            print("Before if qr scanner $text");
            //For Scan Screen move to new screen not to Indexed Stack on home screen
            if (text == Screens.kQrCodeScannerScreen) {
              navigatorGk.currentState.pushNamed(Screens.kQrCodeScannerScreen);
              return;
            }
            print("After if qr scanner $text");


            if (tourVisibilityController.value) {
              // Tour visibility is showing
              return;
            }

            provider.setBottomNavScreen(text);
            navigateToFirstRoute(context);
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

  void navigateToFirstRoute(BuildContext context) {
    navigatorGk.currentState.popUntil((route) => route.isFirst);

    //clear screen backstack
    BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
    baseProvider.screenStack.popAll();
  }
}
