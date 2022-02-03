import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/model/today_sv_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/today_sv_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
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

    var body = {"CustomerAccountID": "001p000000y1SqW"};
    apiController.post(EndPoints.TODAY_SV, body: body, headers: await Utility.header())
      ..then((response) {
        List<TodaySvResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(TodaySvResponse.fromJson(element));
        });

        _v.onSvListFetched(brList);

        // if (otpResponse.returnCode)
        //   loginView.onOtpSent(mobileOtp);
        // else
        //   loginView.onError(otpResponse.message);
      })
      ..catchError((e) {
        _v.onError(e.message);
        Utility.log(tag, e.toString());
      });
  }
}
