import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:provider/provider.dart';

import 'persistent_side_navigation.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({this.child});

  final Widget child;
  var drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawerScrimColor: Colors.transparent,
      body: Scaffold(
        key: drawerKey,
        drawerEnableOpenDragGesture: false,
        drawer: Container(
          width: Utility.screenWidth(context),
          color: AppColors.screenBackgroundColor,
          child: Drawer(
            elevation: 0.0,
            child: PersistentSideNavigation(),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      elevation: 0.0,
      title: Text("Piramal Realty", style: textStyleDark18pxW700),
      leading: InkWell(
        onTap: () {
          var baseProvider = Provider.of<BaseProvider>(context, listen: false);
          baseProvider.toggleDrawer();
          drawerKey.currentState.openDrawer();
        },
        child: Row(
          children: [
            horizontalSpace(20.0),
            Container(child: Image.asset(Images.kIconMenu, width: 16.0)),
          ],
        ),
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
        return InkWell(
          onTap: () {
            provider.toggleFilter();
            // setState(() {});
          },
          child: Container(
            height: 40.0,
            width: 40.0,
            padding: EdgeInsets.all(11.0),
            child: Image.asset(
              Images.kIconFilter,
              color: provider.filterIsOpen ? AppColors.colorPrimary : AppColors.colorSecondary,
            ),
          ),
        );
      },
    );
  }
}
