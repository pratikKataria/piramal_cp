import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_read_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/notification_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:provider/provider.dart';

import 'notification_presenter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> implements NotificationView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  NotificationPresenter _homePresenter;

  List<NotificationList> notificationList = [];

  @override
  void initState() {
    _homePresenter = NotificationPresenter(this);
    _homePresenter.getNotificationList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         /*   Consumer<BaseProvider>(
              builder: (_, provider, __) {
                print("Notification consumer rebuilding ${provider.currentScreen}");
                if (provider.currentScreen == Screens.kNotificationsScreen) _homePresenter.getNotificationList(context);
                return Container();
              },
            ),*/
            verticalSpace(22.0),
            Text("Notification (${notificationList.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  _homePresenter.getNotificationList(context);
                },
                children: notificationList.map((e) => buildNotificationCard(e)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell buildNotificationCard(NotificationList notificationList) {
    return InkWell(
      onTap: () {
        _homePresenter.readNotification(context, notificationList.notificationID);

        switch (notificationList?.type) {
          case Constants.NEW_OPPORTUNITY_NOTIFICATION:
            // Navigator.pushNamed(context, Screens.kCPEventScreen);
            BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
            baseProvider.setBottomNavScreen(Screens.kHomeScreen);
            break;
          case Constants.CP_EVENT_NOTIFICATION:
            Navigator.pushNamed(context, Screens.kCPEventScreen);
            BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
            baseProvider.setBottomNavScreen(Screens.kCPEventScreen);
            break;
          case Constants.CURRENT_PROMOTION_NOTIFICATION:
            Navigator.pushNamed(context, Screens.kCurrentPromotionsScreen);
            BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
            baseProvider.setBottomNavScreen(Screens.kCurrentPromotionsScreen);
            break;
        }
      },
      child: Column(
        children: [
          line(),
          verticalSpace(20.0),
          Row(
            children: [
              Opacity(
                opacity: notificationList?.isRead ?? false ? 0 : 1,
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
                ),
              ),
              horizontalSpace(20.0),
              Expanded(
                child: Text(
                  "${notificationList?.body}",
                  style: textStyle14px500w,
                ),
              ),
            ],
          ),
          verticalSpace(20.0),
        ],
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String sText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: const EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$mText",
            style: textStyle14px500w,
          ),
          Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onNotificationListFetched(NotificationResponse brList) {
    notificationList.clear();
    notificationList.addAll(brList.notificationList);
    setState(() {});
  }

  @override
  void onNotificationRead(NotificationReadResponse nResponse) {
    _homePresenter.getNotificationList(context);
  }

  void updateNotification() {
    _homePresenter.getNotificationList(context);
  }
}
