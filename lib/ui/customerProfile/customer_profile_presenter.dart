import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/model/chatresponse.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/walkin_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class CustomerProfilePresenter extends BasePresenter {
  CustomerProfileView _v;
  final tag = "HomePresenter";

  CustomerProfilePresenter(this._v) : super(_v);

  void scheduleTime(BuildContext context, String otyId, DateTime visitDate) async {
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
      ..then((response) {
        Dialogs.hideLoader(context);
        ScheduleVisitResponse visitResponse = ScheduleVisitResponse.fromJson(response.data);
        visitResponse.schDate = visitDate;
        if (visitResponse.returnCode) {
          _v.onSiteVisitScheduled(visitResponse);
        } else {
          _v.onError(visitResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getCustomerUnitDetail(BuildContext context, String otyID) async {
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
    var body = {"CustomerAccountId": "$uID", "CustomerOpportunityId": "$otyID"};

    Dialogs.showLoader(context, "Fetching unit details ...");
    apiController.post(EndPoints.UNIT_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectUnitResponse projectUnitResponse = ProjectUnitResponse.fromJson(response.data);
        _v.onProjectUnitResponseFetched(projectUnitResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getInvoice(BuildContext context, String otyID) async {
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
    var body = {"CustomerAccountID": "$uID", "opportunityid": "$otyID"};

    // var body = {"CustomerAccountID": "001p000000y1SqWAAU", "opportunityid": "006p000000AeMAtAAN"};
    Dialogs.showLoader(context, "Fetching details ...");
    apiController.post(EndPoints.GET_INVOICE, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        InvoiceResponse projectUnitResponse = InvoiceResponse.fromJson(response.data);
        _v.onInvoiceDetailFetched(projectUnitResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void addComments(BuildContext context, String comment, String sfdcID, String siteVisitID) async {
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

    // String uID = await Utility.uID();
    var body = {
      "CustomerOpportunityId": "$sfdcID" /*006p000000Ac0Gn*/,
      "comment": "$comment",
      "SiteVisitID": "$siteVisitID",
    };
    Dialogs.showLoader(context, "Adding comment ...");
    apiController.post(EndPoints.ADD_COMMENTS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        (_v as WalkinView).onCommentAdded();
        // InvoiceResponse projectUnitResponse = InvoiceResponse.fromJson(response.data);
        // _v.onInvoiceDetailFetched(projectUnitResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        // (_v as WalkinView).onCommentAddError("$e");
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getCommentList(BuildContext context, String oID) async {
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

    var body = {"OpportunityID": "$oID"} /*006p000000Ac0Gn*/;
    // var body = {"OpportunityID": "006p000000Ac0Gn"} /*006p000000Ac0Gn*/;

    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.GET_COMMENTS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List<Chatresponse> projectListResponse = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => projectListResponse.add(Chatresponse.fromJson(element)));

        Chatresponse bookingResponse = projectListResponse.isNotEmpty ? projectListResponse.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        WalkinView v = _v as WalkinView;
        if (bookingResponse.returnCode) {
          v.onWalkinCommentFetched(projectListResponse);
        } else {
          // _v.onError(bookingResponse.message);
          v.onNoVisitFound();
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
