import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/upload/upload_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'model/upload_file_response.dart';

class UploadPresenter {
  UploadView _v;
  final tag = "UploadPresenter";

  UploadPresenter(this._v);

  void uploadNoteAndAttachments(BuildContext context, String note, fileName, fileExt, String file) async {
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

    if (file == null || file.isEmpty) {
      _v.onError("Please select file");
      return;
    }

    String uID = await Utility.uID();
    var body = {
      "CustomerAccountId": uID,
      "DocName": fileName,
      "Description": note,
      "fileType": fileExt,
      "attachFile": file,
    };

    Dialogs.showLoader(context, "Uploading your file ...");
    apiController.post(EndPoints.UPLOAD, body: body, headers: await Utility.header())
      ..then((Response response) {
        Dialogs.hideLoader(context);
        UploadFileResponse nResponse = UploadFileResponse.fromJson(response.data);

        if (nResponse.returnCode == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (nResponse.returnCode != null) {
          _v.onFileUploaded(nResponse);
        } else {
          _v.onError(nResponse.message);
        }
      })
      ..catchError((e) async {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
