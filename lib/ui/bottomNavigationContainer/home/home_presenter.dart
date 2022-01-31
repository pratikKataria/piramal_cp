import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'home_view.dart';
import 'model/booking_response.dart';

class HomePresenter {
  HomeView _v;
  final tag = "CorePresenter";

  HomePresenter(this._v);

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

    var body = {"CustomerAccountId": "001p000000y1SqW"};
    Dialogs.showLoader(context, "Please wait fetching your data ...");
    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onBookingListFetched(brList);

        // if (otpResponse.returnCode)
        //   loginView.onOtpSent(mobileOtp);
        // else
        //   loginView.onError(otpResponse.message);
      })
      ..catchError((e) {
        _v.onError(e.message);
        Dialogs.hideLoader(context);
        Utility.log(tag, e.toString());
      });
  }

  void getWalkInList() async {
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

    var body = {"CustomerAccountId": "001p000000y1SqW"};

    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onWalkInListFetched(brList);

        // if (otpResponse.returnCode)
        //   loginView.onOtpSent(mobileOtp);
        // else
        //   loginView.onError(otpResponse.message);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void scheduleTime(BuildContext context, String otyId, String visitDate) async {
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
      "CustomerAccountId": "001p000000y1SqW",
      "CustomerOpportunityId": otyId,
      "Dateofvisit": visitDate //2022-1-21
    };

    Dialogs.showLoader(context, "Please wait scheduling your visit ...");

    apiController.post(EndPoints.SCHEDULE_VISIT, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ScheduleVisitResponse visitResponse = ScheduleVisitResponse.fromJson(response.data);
        if (visitResponse.returnCode) {
          _v.onSiteVisitScheduled(visitResponse);
        } else {
          _v.onError(visitResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
