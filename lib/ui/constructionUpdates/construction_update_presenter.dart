import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_view.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/model/construction_update_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ConstructionUpdatePresenter {
  ConstructionUpdateView _v;
  final tag = "LeadPresenter";

  ConstructionUpdatePresenter(this._v);

  void getProjectList(BuildContext context, String tID) async {
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

    if (kDebugMode) tID = "a04N000000HqMLWIA3";
    var body = {"TowerId": tID};

    Dialogs.showLoader(context, "Please wait fetching your construction update...");
    apiController.post(EndPoints.CP_APP_CONSTRUCTION_UPDATES, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        ConstructionUpdateResponse constructionUpdateResponse = ConstructionUpdateResponse.fromJson(response.data);
        if (constructionUpdateResponse.returnCode) {
          _v.onConstructionImagesFetched(constructionUpdateResponse.constructionUpdatesList);
        } else {
          _v.onError(constructionUpdateResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
