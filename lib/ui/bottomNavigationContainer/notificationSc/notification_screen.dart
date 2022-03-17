import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/notification_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/notification_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> implements NotificationView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  NotificationPresenter _homePresenter;

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
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(22.0),
            Text("Notification (5)", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: ListView(
                children: [
                  //one
                  line(),
                  verticalSpace(20.0),
                  buildNotificationCard(
                      false, "New offers for Piramal Mahalaxmi north Tower coming soon. Stay tuned to know more."),
                  verticalSpace(20.0),

                  //two
                  line(),
                  verticalSpace(20.0),
                  buildNotificationCard(false, "Alert: Please approve your latest walk in to complete the tagging process."),
                  verticalSpace(20.0),

                  //three
                  line(),
                  verticalSpace(20.0),
                  buildNotificationCard(true, "A gentle reminder to complete today’s follow-ups.s"),
                  verticalSpace(20.0),

                  //four
                  line(),
                  verticalSpace(20.0),
                  buildNotificationCard(true, "Mr. Anil Nath’s opportunity expires in 3 days."),
                  verticalSpace(20.0),

                  //five
                  line(),
                  verticalSpace(20.0),
                  buildNotificationCard(true, "You have 3 missed follow-ups."),
                  verticalSpace(20.0),

                  //five
                  line(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationCard(bool notificationIsRead, String text) {
    return Row(
      children: [
        Opacity(
          opacity: notificationIsRead ? 0 : 1,
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
          ),
        ),
        horizontalSpace(20.0),
        Expanded(
          child: Text(
            "$text",
            style: textStyle14px500w,
          ),
        ),
      ],
    );
  }

  Container buildProfileDetailCard(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 18.0),
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
  void onNotificationListFetched(List<NotificationResponse> brList) {
    print("NotificationList $brList");
  }
}
