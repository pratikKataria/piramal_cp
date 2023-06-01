import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/controller/bottom_navigation_controller.dart';
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

  BaseScreen({this.child});

  void showTour() async {
    bool completed = await Utility.isTourCompleted("baseScreen1");
    if (!completed && globalTutorialCoachMark == null) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
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

        if (provider.showAppbarAndBottomNavigation) {
          showTour();
        }


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
              if (tourVisibilityController.value) {
                // Tour visibility is showing
                return;
              }

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
            if (tourVisibilityController.value) {
              // Tour visibility is showing
              return;
            }

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
        Utility.setTourCompleted("baseScreen1");
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
                  Text("    \u2022 Project Details", style: textStyleWhite14px500w),
                  Text("    \u2022 Current Promotions", style: textStyleWhite14px500w),
                  Text("    \u2022 Construction Update", style: textStyleWhite14px500w),
                  Text("    \u2022 Videos", style: textStyleWhite14px500w),
                  Text("    \u2022 UpComing Events", style: textStyleWhite14px500w),
                  Text("    \u2022 View/Add Leads", style: textStyleWhite14px500w),
                  Text("    \u2022 Edit/ View Profile", style: textStyleWhite14px500w),
                  Text("    \u2022 Video Updates", style: textStyleWhite14px500w),
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
                      Text("    \u2022 Financial Year & Quarters - Leads, Walk-ins & Bookings", style: textStyleWhite14px500w),
                      Text("    \u2022 View/ Download Due Invoices", style: textStyleWhite14px500w),
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
                  // 1. Upload Leads
                  // 2. Walk-in Details - Validity & Status
                  // 3. Bookings - Customer payment status, Invoice Status & Booking details
                  Text("Home Screen", style: textStyleWhite14px600w),
                  Text("\u2022 Upload Leads", style: textStyleWhite14px500w),
                  Text("\u2022 Walk-in Details - Validity & Status", style: textStyleWhite14px500w),
                  Text("\u2022 Bookings - Customer payment status, Invoice Status & Booking details", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );

    /*targets.add(
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
    );*/

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
                  Text("    \u2022 Bulk Lead Upload via Excel Sheet", style: textStyleWhite14px500w),
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
                      "View & Add the follow-ups for client walkins",
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
                      "Stay updated on all the new offers, events and client updates",
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
