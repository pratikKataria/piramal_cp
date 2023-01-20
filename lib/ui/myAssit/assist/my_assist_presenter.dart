import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'model/my_assist_response.dart';
import 'my_assist_view.dart';

class MyAssistPresenter {
  MyAssistView _v;
  final tag = "LeadPresenter";

  MyAssistPresenter(this._v);

  void getAssistData(BuildContext context, String id) async {
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
      "ProjectID": "$id",
      "CustomerAccountId": uID,
    };

    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.MY_ASSIST, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        MyAssistResponse m = MyAssistResponse.fromJson(response.data);
        if (m.returnCode) {
          _v.onAssistDataFetched(m);
        } else {
          _v.onError(m.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
