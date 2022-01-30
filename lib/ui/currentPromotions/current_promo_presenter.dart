import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/current_promo_view.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/model/current_promo_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class CurrentPromoPresenter {
  CurrentPromoView _v;
  final tag = "LeadPresenter";

  CurrentPromoPresenter(this._v);

  void getProjectList(BuildContext context) async {
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
      "currentPromotionList": [{}]
    };

    apiController.post(EndPoints.CURRENT_PROMOTIONS, body: body, headers: await Utility.header())
      ..then((response) {
        List<CurrentPromoResponse> listOfPromotions = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          listOfPromotions.add(CurrentPromoResponse.fromJson(element));
        });

        _v.onCurrentPromoListFetched(listOfPromotions);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }
}
