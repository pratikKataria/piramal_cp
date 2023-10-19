import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/env/environment_values.dart';
import 'package:piramal_channel_partner/global/variables.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/core/core_view.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_guest_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_validation_check_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_view.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/model/post_user_document_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/model/type_of_document_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/ui/qrCodeScanner/model/update_pax_size_response.dart';
import 'package:piramal_channel_partner/ui/qrCodeScanner/qr_code_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class QrCodeScannerPresenter extends BasePresenter {
  QRCodeView _v;
  final tag = "CorePresenter";

  QrCodeScannerPresenter(this._v) : super(_v);

  void updatePaxSize(BuildContext context, String eventJson, String value) async {
    try {
      //check for internal token
      if (await AuthUser.getInstance().hasToken()) {
        _v.onError("Token not found");
        return;
      }

      //check network
      if (!await NetworkCheck.check()) return;

      Map<String, dynamic> event = jsonDecode(eventJson);

      String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;
      var body = {
        "AccountID": accountId,
        "parentCPEventId": event["eventId"],
        "Actual_Paxsize": value,
      };

      Dialogs.showLoader(context, "Updating Pax Size ...");
      apiController.post(EndPoints.UPDATE_ACTUAL_PAX_SIZE, body: body, headers: await Utility.header())
        ..then((response) async {
          await Dialogs.hideLoader(context);

          UpdatePaxSizeResponse updatePaxSizeResponse = UpdatePaxSizeResponse.fromJson(response.data);
          if (updatePaxSizeResponse.returnCode) {
            _v.onPaxSizeUpdated();
          } else {
            _v.onError(updatePaxSizeResponse.message);
          }
        })
        ..catchError((e) async {
          await Dialogs.hideLoader(context);
          _v.onError(e.message);
          Utility.log(tag, e.toString());
        });

    } catch(error) {
      _v.onError("Incorrect QR Code");
    }

  }

}
