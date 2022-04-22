import 'package:dio/dio.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/env/environment_values.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
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
      ..then((response) {
        TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
        HomeView loginView = _v as HomeView;
        loginView.onTokenRegenerated(tokenResponse);
      })
      ..catchError((e) {});
  }

  void downloadFile(String link) async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    apiController.get(link)
      ..then((response) {
        Utility.log(tag, response);
        // TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
        // HomeView loginView = _v as HomeView;
        // loginView.onTokenRegenerated(tokenResponse);
      })
      ..catchError((e) {});
  }
}
