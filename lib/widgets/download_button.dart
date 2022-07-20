import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/model/project_download_link_reponse.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class DownloadButton extends StatelessWidget {
  final String projectId;
  final String fileIdentifier;
  Function callBackFunction;

  DownloadButton(this.projectId, this.fileIdentifier, {Function onActionComplete, Key key}) : super(key: key) {
    callBackFunction = onActionComplete;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Utility.launchUrlX(context, projectId);
        downloadFile(context);
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorPrimary,
        ),
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          Images.kIconDownload,
        ),
      ),
    );
  }

  void downloadFile(BuildContext context) async {
    if (!await NetworkCheck.check()) {
      // _v.onError("");
      Utility.showErrorToastB(context, "No Network Found");
      return;
    }

    var body = {"LinkedEntityId": "$projectId", "FileName": "$fileIdentifier"};

    Dialogs.showLoader(context, "Getting your file ready please wait ...");
    apiController.post(EndPoints.GET_PROJECT_DOWNLOAD_LINK, body: body, headers: await Utility.header())
      ..then((response) async {
        Dialogs.hideLoader(context);
        Utility.log("Download Button", response);
        ProjectDownloadLinkReponse projectDownloadLinkReponse = ProjectDownloadLinkReponse.fromJson(response.data);

        if (projectDownloadLinkReponse.returnCode) {
          callBackFunction();
          Utility.launchUrlX(context, projectDownloadLinkReponse?.downloadlink);
        } else {
          Utility.showErrorToastB(context, projectDownloadLinkReponse.message);
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        Utility.log("Download Button", e);
        Utility.showErrorToastB(context, "$e");
      });
  }
}

/* if (projectDownloadLinkReponse?.downloadlink == null || (projectDownloadLinkReponse?.downloadlink?.isEmpty ?? true)) {
            Utility.showErrorToastB(context, "No Link!");
            return;
          }
*/
