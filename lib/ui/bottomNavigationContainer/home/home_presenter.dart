import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'home_view.dart';
import 'model/booking_response.dart';

class HomePresenter {
  HomeView _v;
  final tag = "CorePresenter";

  HomePresenter(this._v);

  void getBookingList() async {
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

    var body = {"CustomerAccountId": "001p000000y1SqW"};

    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((response) {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onBookingListFetched(brList);

        // if (otpResponse.returnCode)
        //   loginView.onOtpSent(mobileOtp);
        // else
        //   loginView.onError(otpResponse.message);
      })
      ..catchError((e) {
        _v.onError(e.message);
        Utility.log(tag, e.toString());
      });
  }

  void getWalkInList() async {
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

    var body = {"CustomerAccountId": "001p000000y1SqW"};

    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(BookingResponse.fromJson(element));
        });

        _v.onWalkInListFetched(brList);

        // if (otpResponse.returnCode)
        //   loginView.onOtpSent(mobileOtp);
        // else
        //   loginView.onError(otpResponse.message);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }
}
