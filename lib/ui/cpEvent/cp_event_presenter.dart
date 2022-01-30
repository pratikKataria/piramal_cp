import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_view.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
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

    var body = {"AccountID": "001p000000wiszQ"};

    apiController.post(EndPoints.CP_EVENT_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        List<CpEventResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(CpEventResponse.fromJson(element));
        });

        _v.onEventFetched(brList);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }
}
