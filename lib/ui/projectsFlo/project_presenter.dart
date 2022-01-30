import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
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

    apiController.post(EndPoints.ALL_PROJECT_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        List<ProjectListResponse> projectListResponse = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          projectListResponse.add(ProjectListResponse.fromJson(element));
        });

        (_v as ProjectView).onProjectListFetched(projectListResponse);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }
}
