import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/model/today_sv_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/today_sv_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class TodaySVPresenter {
  TodayView _v;
  final tag = "TodaySVPresenter";

  TodaySVPresenter(this._v);

  void getSvList(BuildContext context) async {
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

    String userId = await Utility.uID();
    var body = {"CustomerAccountID": "$userId"} /*001p000000y1SqW*/;
    apiController.post(EndPoints.TODAY_SV, body: body, headers: await Utility.header())
      ..then((response) async {
        List<TodaySvResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(TodaySvResponse.fromJson(element)));

        _v.onSvListFetched(brList);
      })
      ..catchError((e) async {
        _v.onError(e.message);
        Utility.log(tag, e.toString());
      });
  }

  void completeTagging(BuildContext context, String oId, String taskId) async {
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

    /*{
      "CustomerAccountId": "001p000000y1SqW",
    "OpportunityId": "006p00000092HFKAA2",
    "CompleteTag": "false",
    "TaskId": "00Tp000000HpLsy"
    }*/

    String userId = await Utility.uID();
    var body = {
      "CustomerAccountId": "$userId",
      "OpportunityId": "$oId",
      "CompleteTag": true,
      // "TaskId": "$taskId",
    };

    Dialogs.showLoader(context, "Tagging customer please wait ...");
    apiController.post(EndPoints.COMPLETE_TAGGING, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        List<OTPResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(OTPResponse.fromJson(element)));

        OTPResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onTaggingDone();
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
