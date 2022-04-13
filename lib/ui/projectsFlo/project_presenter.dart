import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_amenities_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_download_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_bottom_images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_images_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_tower_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/project_detail_view.dart';
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

  /*
  *
  *
  *
  * Project detail
  * */

  void getProjectOverview(BuildContext context, String projectID) async {
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

    var body = {"ProjectID": "$projectID"};
    // var body = {"ProjectID": "a03N0000005NHiTIAW"};
    Dialogs.showLoader(context, "Please wait fetching your project details ...");
    apiController.post(EndPoints.PROJECT_OVERVIEW, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectOverviewResponse projectOverviewResponse = ProjectOverviewResponse.fromJson(response.data);
        (_v as ProjectDetailView).onProjectOverviewDetailsFetched(projectOverviewResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getProjectAmenities(BuildContext context, String projectId) async {
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

    var body = {"ProjectID": projectId};
    // var body = {"ProjectID": "a03N0000005NHiTIAW"};
    // Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.PROJECT_AMENITIES, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        ProjectAmenitiesResponse projectAmenitiesResponse = ProjectAmenitiesResponse.fromJson(response.data);
        (_v as ProjectDetailView).onProjectAmenitiesFetched(projectAmenitiesResponse);
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTowerList(BuildContext context, String projectId) async {
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

    var body = {"ProjectID": "$projectId"};
    // Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.PROJECT_TOWER, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);

        List<ProjectTowerResponse> projectListResponse = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          projectListResponse.add(ProjectTowerResponse.fromJson(element));
        });

        (_v as ProjectDetailView).onProjectTowerListFetched(projectListResponse);
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  // void getProjectPics(BuildContext context, String projectId) async {
  //   //check for internal token
  //   if (await AuthUser.getInstance().hasToken()) {
  //     _v.onError("Token not found");
  //     return;
  //   }
  //
  //   //check network
  //   if (!await NetworkCheck.check()) {
  //     _v.onError("Network Error");
  //     return;
  //   }
  //   // "ProjectID":""
  //   var body = {"ProjectID": "$projectId"};
  //   // var body = {"ProjectID": "a03N0000005NHiTIAW"};
  //   // Dialogs.showLoader(context, "Please wait fetching your project list ...");
  //   apiController.post(EndPoints.PROJECT_IMAGES, body: body, headers: await Utility.header())
  //     ..then((response) {
  //       // Dialogs.hideLoader(context);
  //       List<ProjectOverviewImagesResponse> brList = [];
  //       var listOfDynamic = response.data as List;
  //       listOfDynamic.forEach((element) => brList.add(ProjectOverviewImagesResponse.fromJson(element)));
  //
  //       ProjectOverviewImagesResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
  //       if (bookingResponse == null) {
  //         _v.onError(Screens.kErrorTxt);
  //         return;
  //       }
  //
  //       ProjectDetailView projectDetailView = _v as ProjectDetailView;
  //
  //       if (bookingResponse.returnCode) {
  //         projectDetailView.onProjectImagesFetched(brList);
  //       } else {
  //         // _v.onError(bookingResponse.message);
  //       }
  //     })
  //     ..catchError((e) {
  //       // Dialogs.hideLoader(context);
  //       ApiErrorParser.getResult(e, _v);
  //     });
  // }

  void getDownloadList(BuildContext context, String projectId) async {
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

    var body = {"ProjectID": projectId};
    // var body = {"ProjectID": "a03N0000005NHiTIAW"};
    // Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.PROJECT_GALLERY, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);

        List<ProjectDownloadResponse> projectListResponse = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          ProjectDownloadResponse projectDownloadResponse = ProjectDownloadResponse.fromJson(element);
          projectDownloadResponse?.projectId = projectId;
          projectListResponse.add(projectDownloadResponse);
        });

        (_v as ProjectDetailView).onProjectDownloadListFetched(projectListResponse);
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getProjectBottomPics(BuildContext context, String projectId) async {
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

    var body = {"LinkedEntityId": projectId};

    apiController.post(EndPoints.PROJECT_OVERVIEW_IMAGES, body: body, headers: await Utility.header())
      ..then((response) {
        List<ProjectOverviewBottomImages> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(ProjectOverviewBottomImages.fromJson(element)));
        ProjectOverviewBottomImages imageData = brList.isEmpty ? null : brList.first;
        if (imageData != null && imageData.returnCode) (_v as ProjectDetailView).onProjectBottomImagesFetched(brList);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getProjectBannerPics(BuildContext context, String projectId) async {
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
    // "ProjectID":""
    var body = {"ProjectID": "a03N000000J4W34"};
    // var body = {"ProjectID": "a03N0000005NHiTIAW"};
    // Dialogs.showLoader(context, "Please wait fetching your project list ...");
    apiController.post(EndPoints.PROJECT_IMAGES, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        List<ProjectOverviewImagesResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => brList.add(ProjectOverviewImagesResponse.fromJson(element)));

        ProjectOverviewImagesResponse bookingResponse = brList.isNotEmpty ? brList.first : null;
        if (bookingResponse == null) {
          _v.onError(Screens.kErrorTxt);
          return;
        }

        ProjectDetailView projectDetailView = _v as ProjectDetailView;

        if (bookingResponse.returnCode) {
          projectDetailView.onProjectImagesFetched(brList);
        } else {
          _v.onError(bookingResponse.message);
        }
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
