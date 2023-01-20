import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/account_status_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/device_token_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/payment_confirmation_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'home_view.dart';

class HomePresenter {
  HomeView _v;
  final tag = "HomePresenter";

  HomePresenter(this._v);

  void getBookingList(BuildContext context) async {
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

    // var body = {"CustomerAccountId": "$uID"};
    String uID = await Utility.uID();
    var body = {"CustomerAccountId": "$uID"};

    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((Response response) {
        List<BookingResponse> brList = [];
        List listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(BookingResponse.fromJson(element)));

        BookingResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onBookingListFetched(brList);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        _v.onError(e.message);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getWalkInList(BuildContext context) async {
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

    String uID = await Utility.uID();
    var body = {"CustomerAccountId": "$uID"};
    // var body = {"CustomerAccountId": "001p000000y1SqW"};

    // Dialogs.showLoader(context, "Please wait fetching your data ...");
    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) async {
        // await Dialogs.hideLoader(context);
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(BookingResponse.fromJson(element)));

        BookingResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onWalkInListFetched(brList);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        // await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getWalkInListV2s(BuildContext context) async {
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

    String uID = await Utility.uID();
    var body = {"CustomerAccountId": "$uID"};
    // var body = {"CustomerAccountId": "001p000000y1SqW"};

    apiController.post(EndPoints.GET_WALK_IN, body: body, headers: await Utility.header())
      ..then((response) async {
        List<BookingResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(BookingResponse.fromJson(element)));

        BookingResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onWalkInListFetched(brList);
        } else {
          // _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void scheduleTime(BuildContext context, String name, String otyId, DateTime visitDate) async {
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

    String uID = await Utility.uID();
    String formattedDate = DateFormat("yyyy-MM-ddThh:mm:ss").format(visitDate);
    var body = {
      "OpportunityId": "$otyId",
      "scheduleDateTime": "$formattedDate",
      "CustomerAccountID": uID /*"001p000000y1SqW"*/
    };
    Dialogs.showLoader(context, "Please wait scheduling your visit ...");
    apiController.post(EndPoints.SCHEDULE_VISIT, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        ScheduleVisitResponse visitResponse = ScheduleVisitResponse.fromJson(response.data);
        visitResponse.schDate = visitDate;
        visitResponse.opportunityName = name??"";
        if (visitResponse.returnCode) {
          _v.onSiteVisitScheduled(visitResponse);
        } else {
          _v.onError(visitResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getEventList(BuildContext context) async {
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

    String uID = await Utility.uID();
    var body = {"AccountID": "$uID"};
    // var body = {"AccountID": "001p000000wiszQ"};

    // Dialogs.showLoader(context, "Fetching cp event data ...");
    apiController.post(EndPoints.CP_EVENT_LIST, body: body, headers: await Utility.header())
      ..then((response) async {
        // await Dialogs.hideLoader(context);
        List<CpEventResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(CpEventResponse.fromJson(element)));

        CpEventResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError("No Event Available");
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onEventFetched(brList);
        } else {
          _v.noEventPresent();
        }
      })
      ..catchError((e) async {
        // await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getCustomerUnitDetail(BuildContext context, String otyId) async {
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

    String uID = await Utility.uID();
    var body = {
      "CustomerAccountId": uID /*001N000001S7nkd*/,
      "CustomerOpportunityId": otyId /* "006N000000DuA69"*/,
    };

    Dialogs.showLoader(context, "Fetching unit details ...");
    apiController.post(EndPoints.PROJECT_UNIT_DETAILS, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        ProjectUnitResponse projectUnitResponse = ProjectUnitResponse.fromJson(response.data);
        if (projectUnitResponse.returnCode) {
          _v.onProjectUnitResponseFetched(projectUnitResponse);
        } else {
          _v.onError(projectUnitResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void completeTagging(BuildContext context, String oId, String taskId) async {
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

    /*{
      "CustomerAccountId": "001p000000y1SqW",
    "OpportunityId": "006p00000092HFKAA2",
    "CompleteTag": "false",
    "TaskId": "00Tp000000HpLsy"
    }*/

    String userId = await Utility.uID();
    var body = {
      "CustomerAccountId": "$userId",
      "OpportunityId": "$oId",
      "CompleteTag": true,
    };

    Dialogs.showLoader(context, "Tagging customer please wait ...");
    apiController.post(EndPoints.COMPLETE_TAGGING, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        List<OTPResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(OTPResponse.fromJson(element)));

        OTPResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onTaggingDone();
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getAccountStatusS(BuildContext context) async {
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

    /*{
      "CustomerAccountId": "001p000000y1SqW",
    "OpportunityId": "006p00000092HFKAA2",
    "CompleteTag": "false",
    "TaskId": "00Tp000000HpLsy"
    }*/

    String userId = await Utility.uID();
    var body = {"MobileAppBrokerID": "$userId"};

    // Dialogs.showLoader(context, "Tagging customer please wait ...");
    apiController.post(EndPoints.GET_ACCOUNT_STATUS, body: body, headers: await Utility.header())
      ..then((response) async {
        // await Dialogs.hideLoader(context);

        AccountStatusResponse bookingResponse = AccountStatusResponse.fromJson(response.data);
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onAccountStatusChecked(bookingResponse);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        // await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getAccountStatus(BuildContext context) async {
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

    /*{
      "CustomerAccountId": "001p000000y1SqW",
    "OpportunityId": "006p00000092HFKAA2",
    "CompleteTag": "false",
    "TaskId": "00Tp000000HpLsy"
    }*/

    String userId = await Utility.uID();
    var body = {"MobileAppBrokerID": "$userId"};

    Dialogs.showLoader(context, "Please wait fetching your data ...");
    apiController.post(EndPoints.GET_ACCOUNT_STATUS, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);

        AccountStatusResponse bookingResponse = AccountStatusResponse.fromJson(response.data);
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        if (bookingResponse.returnCode) {
          _v.onAccountStatusChecked(bookingResponse);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void postDeviceToken(BuildContext context) async {
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) {
      _v.onError("Network Error");
      return;
    }

    String deviceToken = await FirebaseMessaging.instance.getToken();
    String userId = await Utility.uID();

    var body = {
      "CustomerAccountID": "$userId",
      "deviceToken": "$deviceToken",
    };
    Utility.log(tag, "Device Token: $deviceToken");

    apiController.post(EndPoints.POST_DEVICE_TOKEN, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        DeviceTokenResponse deviceTokenResponse = DeviceTokenResponse.fromJson(response.data);
        Utility.log(tag, "Device Token: ${deviceTokenResponse?.token}");
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void acknowledgePayment(BuildContext context, String otyID, String brokerId) async {
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

    String uID = await Utility.uID();
    var body = {
      "opportunityid": otyID,
      "CustomerAccountID": uID,
      "BrokerageId": brokerId,
      "CPPaymentConfirmation": true,
    };

    Dialogs.showLoader(context, "Updating payment status ...");
    apiController.post(EndPoints.PAYMENT_CONFIRMATION, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        PaymentConfirmationResponse projectUnitResponse = PaymentConfirmationResponse.fromJson(response.data);
        if (projectUnitResponse.returnCode) _v.onPaymentAcknowledged();
        else _v.onError(projectUnitResponse.message);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
