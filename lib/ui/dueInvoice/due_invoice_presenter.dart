import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/account_status_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/cp_banner_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/current_promotion_blocker_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/device_token_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/payment_confirmation_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'due_invoice_view.dart';

class DueInvoicePresenter {
  DueInvoice _v;
  final tag = "HomePresenter";

  DueInvoicePresenter(this._v);

  void getBookingList(BuildContext context) async {
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
    var body = {"CustomerAccountId": "$uID"};

    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((Response response) {
        List<BookingResponse> brList = [];
        List listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(BookingResponse.fromJson(element)));

        BookingResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onBookingListFetched(brList);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        _v.onError(e.message);
        ApiErrorParser.getResult(e, _v);
      });
  }

}
