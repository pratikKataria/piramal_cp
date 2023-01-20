import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/utils/navigator_gk.dart';
import 'package:provider/provider.dart';

import 'persistent_bottom_navigation.dart';
import 'persistent_side_navigation.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({this.child});

  final Widget child;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  BaseProvider _baseProvider;

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              if (provider.drawerStatus == false)
                provider.openDrawer(); //if drawer is open use close button to close
              else
                provider.closeDrawer(); // if drawer is closed then show menu icon and open drawer
            },
            child: Row(
              children: [
                horizontalSpace(20.0),
                Image.asset(provider.drawerStatus == true ? Images.kIconClose : Images.kIconMenu, width: 16.0)
              ],
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
            provider.currentScreen == Screens.kExploreScreen ||
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
}
