import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_read_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/notification_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class NotificationPresenter {
  NotificationView _v;
  final tag = "HomePresenter";

  NotificationPresenter(this._v);

  void getNotificationList(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) {
      _v.onError("Network Error");
      return;
    }

    String uID = await Utility.uID();
    var body = {"AccountId": "$uID"};
    // var body = {"AccountId": "001p000000zIm0jAAC"};

    apiController.post(EndPoints.NOTIFICATION_LIST, body: body, headers: await Utility.header())
      ..then((Response response) {
        NotificationResponse nResponse = NotificationResponse.fromJson(response.data);

        if (nResponse.returnCode == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (nResponse.returnCode != null) {
          _v.onNotificationListFetched(nResponse);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void readNotification(BuildContext context, String notificationID) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) {
      _v.onError("Network Error");
      return;
    }

    var body = {
      "NotificationID": notificationID,
      "Is_Read": " true",
    };

    apiController.post(EndPoints.READ_NOTIFICATION, body: body, headers: await Utility.header())
      ..then((Response response) {
        NotificationReadResponse nResponse = NotificationReadResponse.fromJson(response.data);

        if (nResponse.returnCode == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (nResponse.returnCode != null) {
          _v.onNotificationRead(nResponse);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }
}
