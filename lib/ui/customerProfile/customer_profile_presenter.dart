import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/generate_invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_number_request.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_number_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_terms_and_condition.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/payment_confirmation_response.dart';
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
      ..then((response) {
        Dialogs.hideLoader(context);
        PaymentConfirmationResponse projectUnitResponse = PaymentConfirmationResponse.fromJson(response.data);
        if (projectUnitResponse.returnCode) {
          _v.onPaymentAcknowledged();
        } else {
          _v.onError(projectUnitResponse.message);
        }
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

        List<InvoiceResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(InvoiceResponse.fromJson(element)));

        InvoiceResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        _v.onInvoiceDetailFetched(brList);
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

  void postGenerateInvoice(BuildContext context, String otyID, String brokerId) async {
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

    String uId = await Utility.uID();
    // var body = {"CustomerAccountID": "$uId", "opportunityid": "$otyID"};
    var body = {
      "opportunityid": otyID, //006p000000BExTl,
      "CustomerAccountID": uId, //001p000000zxu63,
      "generateInvoice": true,
      "BrokerageId": brokerId,
    };
    // var body = {"CustomerAccountID": "001p000000y1SqWAAU", "opportunityid": "006p000000AeMAtAAN"};
    Dialogs.showLoader(context, "Generating invoice ...");
    apiController.post(EndPoints.POST_GENERATE_INVOICE, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);

        GenerateInvoiceResponse bookingResponse = GenerateInvoiceResponse.fromJson(response.data);

        if (bookingResponse.returnCode) {
          _v.onInvoiceGenerated(bookingResponse);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTermsAndCondition(BuildContext context) async {
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

    Dialogs.showLoader(context, "Getting T&C ...");
    apiController.post(EndPoints.POST_INVOICE_TERMS_AND_CONDITION, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);

        InvoiceTermsAndCondition invoiceTermsAndCondition = InvoiceTermsAndCondition.fromJson(response.data);

        if (invoiceTermsAndCondition.returnCode) {
          _v.onTermsAndConditionFetched(invoiceTermsAndCondition.termsAndCondition);
        } else {
          _v.onError(invoiceTermsAndCondition.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void postSaveInvoiceNumber(BuildContext context, InvoiceNumberRequest invoiceNumberRequest) async {
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

    String uId = await Utility.uID();

    Map<String, String> body = {
      "opportunityid": invoiceNumberRequest.otyId,
      "CustomerAccountID": uId,
      "BrokerageId": invoiceNumberRequest.brokerId,
      "InvoiceNum": invoiceNumberRequest.invoiceNumber,
    };

    Dialogs.showLoader(context, "Saving Invoice No. ...");
    apiController.post(EndPoints.POST_SAVE_INVOICE_NO, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);

        InvoiceNumberResponse invoiceTermsAndCondition = InvoiceNumberResponse.fromJson(response.data);

        if (invoiceTermsAndCondition.returnCode) {
          _v.onInvoiceNumberSaved();
        } else {
          _v.onError(invoiceTermsAndCondition.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
