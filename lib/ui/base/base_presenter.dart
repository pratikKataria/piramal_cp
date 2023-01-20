import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/env/environment_values.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/base/LwcView.dart';
import 'package:piramal_channel_partner/ui/base/model/LwcDownloadResponse.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class BasePresenter {
  BaseView _v;
  final tag = "BasePresenter";

  BasePresenter(this._v);

  void getAccessToken() async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    var bodyReq = EnvironmentValues.getTokenBody();

    var body = FormData.fromMap(bodyReq);
    apiController.post(EndPoints.ACCESS_TOKEN, body: body)
      ..then((response) async {
        TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
        if (_v is HomeView) {
          HomeView loginView = _v as HomeView;
          loginView.onTokenRegenerated(tokenResponse);
        } else if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onTokenGenerated(tokenResponse);
        } else if (_v is SignupView) {
          SignupView loginView = _v as SignupView;
          loginView.onTokenGenerated(tokenResponse);
        }
      })
      ..catchError((e) async {});
  }

  void downloadFile(String link) async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    apiController.get(link)
      ..then((response) async {
        Utility.log(tag, response);
        // TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
        // HomeView loginView = _v as HomeView;
        // loginView.onTokenRegenerated(tokenResponse);
      })
      ..catchError((e) async {});
  }

  void openFileUsingLWC(BuildContext context, String recordId) async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    Map body = {
      "RecordId": recordId,
      "CustomerAccountId": (await AuthUser.getInstance().getCurrentUser()).userCredentials.accountId,
      "Token": (await AuthUser.getInstance().getCurrentUser()).tokenResponse.accessToken,
    };

    Dialogs.showLoader(context, "Preparing lwc download page ...");
    apiController.post(EndPoints.DOWNLOAD_LWC, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response);
        LwcDownloadResponse lwcDownloadResponse = LwcDownloadResponse.fromJson(response.data);
        if (_v is LwcView) {
          LwcView loginView = _v as LwcView;
          if (lwcDownloadResponse.returnCode) loginView.onLwcLinkFetched(lwcDownloadResponse);
          else _v.onError(lwcDownloadResponse.message);
        } else {
          _v.onError("No Lwc View Found");
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
