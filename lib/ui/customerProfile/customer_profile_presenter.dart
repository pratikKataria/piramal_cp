import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
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

    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(visitDate);
    var body = {"OpportunityId": "$otyId", "scheduleDateTime": "$formattedDate"};
    Dialogs.showLoader(context, "Please wait scheduling your visit ...");
    apiController.post(EndPoints.SCHEDULE_VISIT, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ScheduleVisitResponse visitResponse = ScheduleVisitResponse.fromJson(response.data);
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

  void getCustomerUnitDetail(BuildContext context) async {
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

    var body = {"CustomerAccountId": "001N000001S7nkd", "CustomerOpportunityId": "006N000000DuA69"};

    Dialogs.showLoader(context, "Fetching unit details ...");
    apiController.post(EndPoints.PROJECT_UNIT_DETAILS, body: body, headers: await Utility.header())
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

  void getInvoice(BuildContext context) async {
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

    var body = {"CustomerAccountID": "001p000000y1SqWAAU", "opportunityid": "006p000000AeMAtAAN"};
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
}
