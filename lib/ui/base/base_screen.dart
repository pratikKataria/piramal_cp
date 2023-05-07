import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/tour_keys_bottom_navigation.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/utils/navigator_gk.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'persistent_bottom_navigation.dart';
import 'persistent_side_navigation.dart';

TutorialCoachMark globalTutorialCoachMark;

class BaseScreen extends StatelessWidget {
  BuildContext context;

  BaseScreen({this.child}) {
    initState();
  }

  void initState() async {
    bool completed = await Utility.isTourCompleted("baseScreen1");
    if (!completed && globalTutorialCoachMark == null) {
      createTutorial();
      Future.delayed(Duration(milliseconds: 1200), showTutorial);
    }
  }

  final Widget child;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  BaseProvider _baseProvider;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    _baseProvider = Provider.of<BaseProvider>(context, listen: false);
    _baseProvider.drawerKey = drawerKey; // set drawer key to provider when any of the navigation tile is clicked
    return Consumer<BaseProvider>(
      builder: (_, provider, __) {
        print("Base consumer rebuilding ... $child");
        return Scaffold(
          appBar: provider.showAppbarAndBottomNavigation ? buildAppBar(context) : null,
          drawerScrimColor: Colors.transparent,
          body: SafeArea(
            child: Scaffold(
              key: drawerKey,
              drawerEnableOpenDragGesture: false,
              backgroundColor: AppColors.screenBackgroundColor,
              bottomNavigationBar: provider.showAppbarAndBottomNavigation ? PersistentBottomNavigation() : null,
              onDrawerChanged: drawerOpenCloseListener,
              drawer: PersistentSideNavigation(),
              body: Column(
                children: [
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      elevation: 0.0,
      title: Text("Piramal Realty", style: textStyleDark18pxW700),
      leading: Consumer<BaseProvider>(
        builder: (_, provider, __) {
          return InkWell(
            key: menuBtnKey,
            onTap: () {
              if (provider.drawerStatus == false)
                provider.openDrawer(); //if drawer is open use close button to close
              else
                provider.closeDrawer(); // if drawer is closed then show menu icon and open drawer
            },
            child: Row(
              children: [horizontalSpace(20.0), Image.asset(provider.drawerStatus == true ? Images.kIconClose : Images.kIconMenu, width: 16.0)],
            ),
          );
        },
      ),
      actions: [
        buildFilterButton(context),
        horizontalSpace(6.0),
      ],
    );
  }

  Consumer<BaseProvider> buildFilterButton(BuildContext context) {
    return Consumer<BaseProvider>(
      builder: (_, provider, __) {
        bool isBase = provider.currentScreen == Screens.kHomeScreen ||
            provider.currentScreen == Screens.kExploreScreen || provider.currentScreen == Screens.kUpload ||
            provider.currentScreen == Screens.kTodayFollowUpScreen ||
            provider.currentScreen == Screens.kNotificationsScreen;

        return InkWell(
          onTap: () {
            if (isBase) {
              provider.toggleFilter();
            } else {
              if (Dialogs.isDialogVisible()) {
                navigatorGk.currentState.pop();
                return;
              }
              BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);

              if (baseProvider.screenStack.isNotEmpty){
                baseProvider.screenStack.pop();
              }

              if (baseProvider.screenStack.isEmpty) {
                baseProvider.currentScreen = Screens.kHomeScreen;
                baseProvider.setBottomNavScreen(baseProvider.currentScreen);
              }

              navigatorGk.currentState.pop();
            }
            // setState(() {});
          },
          child: isBase
              ? Container(
            height: 40.0,
                  width: 40.0,
                  padding: EdgeInsets.all(11.0),
                  key: filterBtnKey,
                  child: Image.asset(
                    Images.kIconFilter,
                    color: provider.filterIsOpen ? AppColors.colorPrimary : AppColors.colorSecondary,
                  ),
                )
              : Container(
                  height: 40.0,
                  padding: EdgeInsets.all(11.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 16.0, color: AppColors.colorSecondary),
                      horizontalSpace(4.0),
                      Text("Back", style: textStyleDarkRegular16px400w)
                    ],
                  ),
                ),
        );
      },
    );
  }

  //Listen to the drawer open and close
  void drawerOpenCloseListener(bool drawerStatus) {
    //when status is false drawer is closed
    if (drawerStatus == false) _baseProvider.closeDrawer();
  }

  void showTutorial() {
    globalTutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    globalTutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: AppColors.colorPrimary,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Create Tutorial findish");
        Utility.setTourCompleted("baseScreen");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation11",
        keyTarget: menuBtnKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Access Menu Options", style: textStyleWhite14px600w),
                  Text("    \u2022 Projects", style: textStyleWhite14px500w),
                  Text("    \u2022 Current Promotions", style: textStyleWhite14px500w),
                  Text("    \u2022 Videos", style: textStyleWhite14px500w),
                  Text("    \u2022 View/Add Leads", style: textStyleWhite14px500w),
                  Text("    \u2022 Events", style: textStyleWhite14px500w),
                  Text("    \u2022 Profile", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation12",
        keyTarget: filterBtnKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Filter through", style: textStyleWhite14px600w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("    \u2022 Projects", style: textStyleWhite14px500w),
                      Text("    \u2022 Months", style: textStyleWhite14px500w),
                      Text("    \u2022 Due Invoices", style: textStyleWhite14px500w),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation1",
        keyTarget: homeBtnKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Home - Get Information about", style: textStyleWhite14px600w),
                  Text("    \u2022 Leads", style: textStyleWhite14px500w),
                  Text("    \u2022 Walk in", style: textStyleWhite14px500w),
                  Text("    \u2022 Booking", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation2",
        keyTarget: expBtnKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Coming Soon", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation3",
        keyTarget: uploadBtnKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Upload", style: textStyleWhite14px600w),
                  Text("    \u2022 Submit your queries", style: textStyleWhite14px500w),
                  Text("    \u2022 Raise tickets", style: textStyleWhite14px500w),
                  Text("    \u2022 Attach file", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: todayFuBtnKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Today's Fu", style: textStyleWhite14px600w),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Property viewings and inquiries, suggests properties and agents, and offers options to schedule future viewings or connect with an agent for more information.",
                      style: textStyleWhite14px500w,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: notificationBtnKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Notifications", style: textStyleWhite14px600w),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Displays a list of recent notifications from an app or system. It may include alerts, messages, reminders, and other updates, often with the option to take action or dismiss them. The screen can provide a quick overview of important information and help users stay informed and organized.",
                      style: textStyleWhite14px500w,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}
