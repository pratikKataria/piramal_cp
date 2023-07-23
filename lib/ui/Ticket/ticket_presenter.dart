import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/case_subtype_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_request.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_category_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_picklist_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_response.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'model/reopen_response.dart';
import 'ticket_view.dart';

class TicketPresenter extends BasePresenter {
  TicketView _v;

  TicketPresenter(this._v) : super(_v);

  void getTickets(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;
    var body = {"CustomerAccountId": accountId};

    Dialogs.showLoader(context, "Fetching your tickets...");
    apiController.post(EndPoints.GET_TICKETS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        TicketResponse rmDetailResponse = TicketResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onTicketFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketsWithoutLoader(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    //if (await NetworkCheck.check()) return;

    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;
    var body = {"CustomerAccountId": accountId};

    apiController.post(EndPoints.GET_TICKETS, body: body, headers: await Utility.header())
      ..then((response) {
        TicketResponse rmDetailResponse = TicketResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onTicketFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void createTickets(BuildContext context, CreateTicketRequest createTicketRequest) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    createTicketRequest.customerAccountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;


    String hasErrorMessage = validateFields(createTicketRequest);
    if (hasErrorMessage != null) {
      _v.onError(hasErrorMessage);
      return;
    }

    var body = {
      "CustomerAccountId": createTicketRequest.customerAccountId,
      "caseType": createTicketRequest.caseType,
      "caseSubType": createTicketRequest.caseSubType,
      "Source": createTicketRequest.source,
      "Category": createTicketRequest.category,
      "Description": createTicketRequest.description,
      "fileType": createTicketRequest.fileType,
      "attachFile": createTicketRequest.attachFile
    };

    // Dialogs.showLoader(context, "Creating ticket, please wait...");
    apiController.post(EndPoints.POST_CREATE_TICKET, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        CreateTicketResponse rmDetailResponse = CreateTicketResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onTicketCreated(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void reopenTicket(BuildContext context, String ticketId, reopenReason) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    //if (await NetworkCheck.check()) return;

    var body = {"ticketId": ticketId, "Reason": reopenReason};

    Dialogs.showLoader(context, "Submitting your request ...");
    apiController.post(EndPoints.POST_REOPEN_TICKET, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ReopenResponse rmDetailResponse = ReopenResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onTicketReopened(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketCategory(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    //if (await NetworkCheck.check()) return;

    // Dialogs.showLoader(context, "Getting ticket category ...");
    apiController.post(EndPoints.POST_CATEGORY, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        TicketCategoryResponse rmDetailResponse = TicketCategoryResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onTicketCategoryFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketSubCategory(BuildContext context, String category) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    //if (await NetworkCheck.check()) return;

    Map body = {"caseOrigin": category};

    // Dialogs.showLoader(context, "Getting ticket subcategory ...");
    apiController.post(EndPoints.POST_SUB_CATEGORY, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        TicketCategoryResponse rmDetailResponse = TicketCategoryResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onSubCategoryFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketSubCategoryWithLoader(BuildContext context, String category) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    //if (await NetworkCheck.check()) return;

    Map body = {"category": category};

    // Dialogs.showLoader(context, "Getting sub category ...");
    apiController.post(EndPoints.POST_SUB_CATEGORY, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs. hideLoader(context);
        TicketCategoryResponse rmDetailResponse = TicketCategoryResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onSubCategoryFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs. hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketPicklistValues(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    Dialogs.showLoader(context, "Fetching picklist options, please wait...");
    apiController.post(EndPoints.CP_TICKET_PICKLIST, headers: await Utility.header())
      ..then((response) {
        Dialogs. hideLoader(context);
        TicketPicklistResponse rmDetailResponse = TicketPicklistResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.onTicketPicklistFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs. hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketSubType(BuildContext context, String caseType) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    //if (await NetworkCheck.check()) return;

    Map body = {"caseType": caseType};

    apiController.post(EndPoints.CP_TICKET_CASE_SUB_TYPE, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs. hideLoader(context);
        CaseSubtypeResponse rmDetailResponse = CaseSubtypeResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode) {
          _v.caseSubTypeResponse(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs. hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  // Validation function
  String validateFields(CreateTicketRequest createTicketRequest) {
    if (createTicketRequest.customerAccountId == null || createTicketRequest.customerAccountId.isEmpty) {
      return "Customer Account ID is required.";
    }

    if (createTicketRequest.caseType == null || createTicketRequest.caseType.isEmpty) {
      return "Case Type is required.";
    }

    if (createTicketRequest.caseSubType == null || createTicketRequest.caseSubType.isEmpty) {
      return "Case Sub Type is required.";
    }

    if (createTicketRequest.source == null || createTicketRequest.source.isEmpty) {
      return "Source is required.";
    }

    if (createTicketRequest.category == null || createTicketRequest.category.isEmpty) {
      return "Category is required.";
    }

    if (createTicketRequest.description == null || createTicketRequest.description.isEmpty) {
      return "Description is required.";
    }

    // if (createTicketRequest.fileType == null || createTicketRequest.fileType.isEmpty) {
    //   return "File Type is required.";
    // }

    // Note: Since attachFile is optional (nullable), we don't include it in validation.

    return null; // Return null if all fields are valid.
  }
}
