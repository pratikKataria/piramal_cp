import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'home_view.dart';
import 'model/booking_response.dart';

class HomePresenter {
  HomeView _v;
  final tag = "HomePresenter";

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
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        _v.onError(e.message);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getWalkInList(BuildContext context) async {
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
    var body = {"CustomerAccountId": "$uID"};
    // var body = {"CustomerAccountId": "001p000000y1SqW"};

    Dialogs.showLoader(context, "Please wait fetching your data ...");
    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(BookingResponse.fromJson(element)));

        BookingResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onWalkInListFetched(brList);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void getWalkInListV2(BuildContext context) async {
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
    var body = {"CustomerAccountId": "$uID"};
    // var body = {"CustomerAccountId": "001p000000y1SqW"};

    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(BookingResponse.fromJson(element)));

        BookingResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onWalkInListFetched(brList);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void scheduleTime(BuildContext context, String otyId, DateTime visitDate) async {
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
    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(visitDate);
    var body = {
      "OpportunityId": "$otyId",
      "scheduleDateTime": "$formattedDate",
      "CustomerAccountID": uID /*"001p000000y1SqW"*/
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
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void getEventList(BuildContext context) async {
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
    var body = {"AccountID": "$uID"};
    // var body = {"AccountID": "001p000000wiszQ"};

    // Dialogs.showLoader(context, "Fetching cp event data ...");
    apiController.post(EndPoints.CP_EVENT_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        List<CpEventResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(CpEventResponse.fromJson(element)));

        CpEventResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError("No Event Available");
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onEventFetched(brList);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void getCustomerUnitDetail(BuildContext context, String otyId) async {
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
    var body = {
      "CustomerAccountId": uID /*001N000001S7nkd*/,
      "CustomerOpportunityId": otyId /* "006N000000DuA69"*/,
    };

    Dialogs.showLoader(context, "Fetching unit details ...");
    apiController.post(EndPoints.PROJECT_UNIT_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectUnitResponse projectUnitResponse = ProjectUnitResponse.fromJson(response.data);
        if (projectUnitResponse.returnCode) {
          _v.onProjectUnitResponseFetched(projectUnitResponse);
        } else {
          _v.onError(projectUnitResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        // ApiErrorParser.getResult(e, _v);
      });
  }
}
