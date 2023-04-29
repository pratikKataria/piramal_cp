import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/utils/navigator_gk.dart';
import 'package:provider/provider.dart';

class PersistentSideNavigation extends StatelessWidget {
  const PersistentSideNavigation({Key key}) : super(key: key);
  final textStyle = textStyleRegular18pxW500;
  final iconSize = 20.0;
  final iconPadding = 20.0;
  final vSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BaseProvider>(context, listen: false);
    return Container(
      width: Utility.screenWidth(context),
      color: AppColors.screenBackgroundColor,
      child: Drawer(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              // if (!(provider.isLogin?? false)) ...[
              //   Text("Login to view your profile.", style: textStyle20px500w),
              //   verticalSpace(15.0),
              //   PmlButton(
              //     text: "Log In",
              //     width: 50.0,
              //     height: 36.0,
              //     margin: EdgeInsets.only(right: Utility.screenWidth(context) * 0.65),
              //     onTap: () {
              //       provider.hideToolTip();
              //       closeDrawerAndNavigation(provider, Screens.kLoginScreen);
              //     },
              //   ),
              // ],
              verticalSpace(40.0),

              // //Home
              // line(),
              // verticalSpace(vSpacing),
              // sideNavButton(provider, Screens.kHomeScreen, Images.kIconHome, "Home"),
              // verticalSpace(vSpacing),
              // line(),

              //Projects
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kProjectScreen, Images.kIconProjects, "Projects"),
              verticalSpace(vSpacing),
              line(),

              //Current Promotions
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kCurrentPromotionsScreen, Images.kIconCurrentPromotion, "Current Promotions"),
              verticalSpace(vSpacing),
              line(),

              //Video
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kVideoScreen, Assets.imagesIcVideo, "Video"),
              verticalSpace(vSpacing),
              line(),

              //View/Add Leads
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kLeadScreen, Images.kIconLeads, "View/Add Leads"),
              verticalSpace(vSpacing),
              line(),

              //CP Events
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kCPEventScreen, Images.kIconCpEvents, "CP Events"),
              verticalSpace(vSpacing),
              line(),

              //My Assists
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kMyAssistProjectScreen, Images.kIconAssist, "My Assists"),
              verticalSpace(vSpacing),
              line(),

              //Settings
              verticalSpace(vSpacing),
              sideNavButton(provider, Screens.kSettingsScreen, Images.kIconSetting, "Profile"),
              verticalSpace(vSpacing),
              line(),

              verticalSpace(vSpacing),
              InkWell(
                onTap: () => closeDrawerAndLogout(provider, context),
                child: Container(
                  height: 45,
                  child: Row(
                    children: [
                      Image.asset(Images.kIconSetting, width: iconSize),
                      horizontalSpace(iconPadding),
                      Text("Logout", style: textStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell sideNavButton(BaseProvider provider, String screenName, String icon, String displayText) {
    return InkWell(
      onTap: () => closeDrawerAndNavigation(provider, screenName),
      child: Container(
        height: 45,
        child: Row(
          children: [
            Image.asset(icon, width: iconSize, color: AppColors.colorPrimary),
            horizontalSpace(iconPadding),
            Text("$displayText", style: textStyle),
          ],
        ),
      ),
    );
  }

  void closeDrawerAndNavigation(BaseProvider provider, String screen) {
    if (provider.drawerKey.currentState.isDrawerOpen) provider.closeDrawer();

    //it stops pushing same screen multiple time
    //if it already on top it close navigation and nothing happen
    if (!checkScreenIsAlreadyOnTop(provider, screen)) {
      navigatorGk.currentState.popUntil((route) => route.isFirst);
      navigatorGk.currentState.pushNamed(screen);
      provider.setBottomNavScreen(screen);
    }
  }

  bool checkScreenIsAlreadyOnTop(BaseProvider provider, String screen) {
    return provider.currentScreen == screen;
  }

  void closeDrawerAndLogout(BaseProvider provider, BuildContext context) {
    if (provider.drawerKey.currentState.isDrawerOpen) provider.closeDrawer();
    provider.hideToolTip();

    AuthUser.getInstance().logout();
    navigatorGk.currentState.pop();
    navigatorGk.currentState.pushNamed(Screens.kLoginScreen);
  }
}
