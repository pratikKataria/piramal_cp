import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
  import 'package:piramal_channel_partner/ui/videoScreen/model/video_response_model.dart';
import 'package:piramal_channel_partner/ui/videoScreen/video_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class VideoPresenter {
  VideoView _v;
  final tag = "LeadPresenter";

  VideoPresenter(this._v);

  void getVideoList(BuildContext context) async {
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

    Dialogs.showLoader(context, "Getting project videos...");
    apiController.post(EndPoints.CP_APP_OFFER_VIDEOS, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        VideoResponseModel constructionUpdateResponse = VideoResponseModel.fromJson(response.data);
        if (constructionUpdateResponse.returnCode) {
          _v.onVideoListFetched(constructionUpdateResponse.detailsList);
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
