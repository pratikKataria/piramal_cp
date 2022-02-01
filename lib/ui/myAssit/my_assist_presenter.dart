import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/myAssit/model/my_assist_response.dart';
import 'package:piramal_channel_partner/ui/myAssit/my_assist_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class MyAssistPresenter {
  MyAssistView _v;
  final tag = "LeadPresenter";

  MyAssistPresenter(this._v);

  void getAssistData(BuildContext context) async {
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
      "ProjectID": "a03N000000J4W34"
    };
    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.MY_ASSIST, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List listOfDynamic = response.data as List;
        MyAssistResponse myAssistResponse = MyAssistResponse.fromJson(listOfDynamic.first);
        _v.onAssistDataFetched(myAssistResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
