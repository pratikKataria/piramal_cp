import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/utils/navigator_gk.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class PersistentSideNavigation extends StatelessWidget {
  const PersistentSideNavigation({Key key}) : super(key: key);
  final textStyle = textStyleRegular18pxW500;
  final iconSize = 20.0;
  final iconPadding = 20.0;

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
              Text("Login to view your profile.", style: textStyle20px500w),
              verticalSpace(15.0),
              PmlButton(
                text: "Log In",
                width: 50.0,
                height: 36.0,
                margin: EdgeInsets.only(right: Utility.screenWidth(context) * 0.65),
                onTap: () {
                  provider.hideToolTip();
                  closeDrawerAndNavigation(provider, Screens.kLoginScreen);
                },
              ),
              verticalSpace(40.0),

              //Home
              line(),
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kHomeScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconHome, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("Home", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              //Projects
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kProjectScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconProjects, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("Projects", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              //Current Promotions
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kCurrentPromotionsScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconCurrentPromotion, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("Current Promotions", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              //View/Add Leads
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kLeadScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconLeads, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("View/Add Leads", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              //CP Events
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kCPEventScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconCpEvents, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("CP Events", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              //My Assists
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kMyAssistScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconAssist, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("My Assists", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              //Settings
              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndNavigation(provider, Screens.kSettingsScreen),
                child: Row(
                  children: [
                    Image.asset(Images.kIconSetting, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("Profile", style: textStyle),
                  ],
                ),
              ),
              verticalSpace(20.0),
              line(),

              verticalSpace(20.0),
              InkWell(
                onTap: () => closeDrawerAndLogout(provider, context),
                child: Row(
                  children: [
                    Image.asset(Images.kIconSetting, width: iconSize),
                    horizontalSpace(iconPadding),
                    Text("Logout", style: textStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void closeDrawerAndNavigation(BaseProvider provider, String screen) {
    if (provider.drawerKey.currentState.isDrawerOpen) provider.closeDrawer();

    //it stops pushing same screen multiple time
    //if it already on top it close navigation and nothing happen
    if (!checkScreenIsAlreadyOnTop(provider, screen)) {
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
