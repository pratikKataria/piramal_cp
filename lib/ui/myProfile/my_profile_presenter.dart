import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/myProfile/model/my_profile_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'my_profile_view.dart';

class MyProfilePresenter {
  MyProfileView _v;
  final tag = "LeadPresenter";

  MyProfilePresenter(this._v);

  void getProfileData(BuildContext context) async {
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
      "CustomerAccountID":"001p000000y1SqWAAU"
    };

    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.MY_PROFILE, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        MyProfileResponse myAssistResponse = MyProfileResponse.fromJson(response.data);
        _v.onProfileDataFetch(myAssistResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
