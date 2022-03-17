import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
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

    // var body = {"CustomerAccountId": "$uID"};
    String uID = await Utility.uID();
    // var body = {"CustomerAccountId": "$uID"};
    var body = {"NotificationID": "a32p0000000fDgdAAE", "Is_Read": " true"};
    apiController.post(EndPoints.NOTIFICATION_LIST, body: body, headers: await Utility.header())
      ..then((Response response) {
        List<NotificationResponse> brList = [];
        List listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(NotificationResponse.fromJson(element)));

        NotificationResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode != null) {
          _v.onNotificationListFetched(brList);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        _v.onError(e.message);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
