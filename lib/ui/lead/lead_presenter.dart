import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/model/create_lead_request.dart';
import 'package:piramal_channel_partner/ui/lead/lead_marker_interface.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';
import 'package:piramal_channel_partner/ui/lead/model/delete_lead_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/user/CurrentUser.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'lead_view.dart';

class LeadPresenter {
  LeadMarkerInterface _v;
  final tag = "LeadPresenter";

  LeadPresenter(this._v);

  void getLeadList(BuildContext context) async {
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

    apiController.post(EndPoints.ALL_LEAD_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        List<AllLeadResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(AllLeadResponse.fromJson(element));
        });

        (_v as LeadView).onAllLeadFetched(brList);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void deleteLead(BuildContext context, AllLeadResponse leadData) async {
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
      "cpleadid": "${leadData.sfdcid}",
    };

    apiController.post(EndPoints.DELETE_LEAD, body: body, headers: await Utility.header())
      ..then((response) {
        DeleteLeadResponse deleteLeadResponse = DeleteLeadResponse.fromJson(response.data);
        deleteLeadResponse.leadId = leadData.sfdcid;
        (_v as LeadView).onLeadDeleted(leadData);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void createLead(BuildContext context, CreateLeadRequest request) async {
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

    //add customer id
    CurrentUser currentUser = await AuthUser.getInstance().getCurrentUser();
    request.customerAccountId = currentUser.userCredentials.accountId;

    apiController.post(EndPoints.CREATE_LEAD, body: request.toJson(), headers: await Utility.header())
      ..then((response) {
        // DeleteLeadResponse deleteLeadResponse = DeleteLeadResponse.fromJson(response.data);
        // deleteLeadResponse.leadId = leadData.sfdcid;
        // (_v as LeadView).onLeadDeleted(leadData);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }
}
