import 'package:dio/dio.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';

class BasePresenter {
  BaseView _v;
  final tag = "CorePresenter";

  BasePresenter(this._v);

  void getAccessToken() async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    var bodyReq = {
      "grant_type": "password",
      "client_id": "3MVG9Se4BnchkASnJ0eDEZX9z9D7w5.Useb0G1N5w8TloI60n3z2sLOgAP.kQJMu4cDVDD6R8ZoiI52dTnngF",
      "client_secret": "ABBF4E5B2A89FD49A3FE015D63A715BDA2D7CA9CE54AD3991560E98276387FB4",
      "username": "aniket.khillari1010@stetig.in",
      "password": "Mobileapp@123u0vS6ZiRg9RNJHRVr9WeO1jpY",
    };

    var body = FormData.fromMap(bodyReq);
    apiController.post(EndPoints.ACCESS_TOKEN, body: body)
      ..then((response) {
        TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
        HomeView loginView = _v as HomeView;
        loginView.onTokenRegenerated(tokenResponse);
      })
      ..catchError((e) {

      });
  }
}
