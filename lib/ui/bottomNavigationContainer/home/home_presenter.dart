import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
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
    String uID = await Utility.uID();
    var body = {"CustomerAccountId": "$uID"};

    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((response) {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onBookingListFetched(brList);
      })
      ..catchError((e) {
        _v.onError(e.message);
        Utility.log(tag, e.toString());
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

    Dialogs.showLoader(context, "Please wait fetching your data ...");
    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onWalkInListFetched(brList);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
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

    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onWalkInListFetched(brList);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
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

    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(visitDate);
    var body = {"OpportunityId": "$otyId", "scheduleDateTime": "$formattedDate"};
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

    var body = {"AccountID": "001p000000wiszQ"};

    // Dialogs.showLoader(context, "Fetching cp event data ...");
    apiController.post(EndPoints.CP_EVENT_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        List<CpEventResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(CpEventResponse.fromJson(element));
        });

        _v.onEventFetched(brList);
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getCustomerUnitDetail(BuildContext context) async {
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

    var body = {"CustomerAccountId": "001N000001S7nkd", "CustomerOpportunityId": "006N000000DuA69"};

    Dialogs.showLoader(context, "Fetching unit details ...");
    apiController.post(EndPoints.PROJECT_UNIT_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectUnitResponse projectUnitResponse = ProjectUnitResponse.fromJson(response.data);
        _v.onProjectUnitResponseFetched(projectUnitResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
