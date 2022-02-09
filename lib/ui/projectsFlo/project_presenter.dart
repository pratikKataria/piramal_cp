import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_amenities_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pageViews/project_detail_amenities_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pageViews/project_detail_overview_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ProjectPresenter {
  ProjectMarkerInterface _v;
  final tag = "LeadPresenter";

  ProjectPresenter(this._v);

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
      "projectList": [{}]
    };
    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.ALL_PROJECT_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        List<ProjectListResponse> projectListResponse = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          projectListResponse.add(ProjectListResponse.fromJson(element));
        });

        (_v as ProjectView).onProjectListFetched(projectListResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getProjectOverview(BuildContext context) async {
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
      "projectList": [{}]
    };
    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.PROJECT_OVERVIEW, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectOverviewResponse projectOverviewResponse = ProjectOverviewResponse.fromJson(response.data);
        (_v as ProjectDetailOverviewView).onProjectOverviewDetailsFetched(projectOverviewResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getProjectAmenities(BuildContext context) async {
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

    var body = {"ProjectID": "a03N0000005NHiTIAW"};
    Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.PROJECT_AMENITIES, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectAmenitiesResponse projectAmenitiesResponse = ProjectAmenitiesResponse.fromJson(response.data);

        (_v as ProjectDetailAmenitiesView).onProjectAmenitiesFetched(projectAmenitiesResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
