import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_view.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_status_update_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class CPEventPresenter {
  CPEventView _v;
  final tag = "LeadPresenter";

  CPEventPresenter(this._v);

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
    var body = {"AccountID": uID}; /*001p000000wiszQ*/

    Dialogs.showLoader(context, "Fetching cp event data ...");
    apiController.post(EndPoints.CP_EVENT_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List<CpEventResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(CpEventResponse.fromJson(element)));

        CpEventResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onEventFetched(brList);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void revertToEvent(BuildContext context, String status, String size, String eventId) async {
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

    //check network
    if (status == "Attend" || status == "Tentative") {
      if (size == "0") {
        _v.onError("Please enter pax size");
        return;
      }
    }


    String uID = await Utility.uID();
    var body = {
      "AccountID": "$uID",
      "CPEventID": "$eventId",
      "status": "$status",
      "paxsize": "$size",
    };

    Dialogs.showLoader(context, "Updating event status ...");
    apiController.post(EndPoints.CP_EVENT_AVAILABILITY, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        CpEventStatusUpdateResponse cpEventStatusUpdateResponse = CpEventStatusUpdateResponse.fromJson(response.data);
        if (cpEventStatusUpdateResponse.returnCode) {
          _v.onCpEventStatusUpdated(cpEventStatusUpdateResponse);
        } else {
          _v.onError(cpEventStatusUpdateResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
