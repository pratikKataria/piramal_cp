import 'dart:io';

import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/model/project_download_link_reponse.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButtonV2 extends StatelessWidget {
  final String projectId;
  final String identifier;

  const WhatsAppButtonV2(this.projectId, this.identifier, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getFileLink(context, projectId, identifier);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorPrimaryLight,
        ),
        child: Image.asset(Images.kIconWhatsApp),
      ),
    );
  }

  void getFileLink(BuildContext context, String projectId, String identifier) async {
    if (!await NetworkCheck.check()) {
      // _v.onError("");
      Utility.showErrorToastB(context, "No Network Found");
      return;
    }

    var body = {"LinkedEntityId": "$projectId", "FileName": "$identifier"};

    Dialogs.showLoader(context, "Getting your file ready please wait ...");
    apiController.post(EndPoints.GET_PROJECT_DOWNLOAD_LINK, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log("Download Button", response);
        ProjectDownloadLinkReponse projectDownloadLinkReponse = ProjectDownloadLinkReponse.fromJson(response.data);

        if (projectDownloadLinkReponse.returnCode) {
          openWhatsapp(context, projectDownloadLinkReponse.downloadlink);
        } else {
          Utility.showErrorToastB(context, projectDownloadLinkReponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        Utility.log("Download Button", e);
        Utility.showErrorToastB(context, "$e");
      });
  }

  openWhatsapp(BuildContext context, String link) async {
    String whatsapp = link ?? "Hi";
    whatsapp = whatsapp.replaceAll("&", "%26");
    var whatsappURl_android = "http://api.whatsapp.com/send?text=${Uri.parse(whatsapp)}";
    var whatappURL_ios = "https://api.whatsapp.com/send?text=${Uri.parse(whatsapp)}";
    print(whatsappURl_android);

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        Utility.showErrorToastB(context, "Whatsapp not installed");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        Utility.showErrorToastB(context, "Failed to open Whatsapp");
      }
    }
  }
}

// if (Platform.isAndroid) {
//   // add the [https]
//   return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
// } else {
//   // add the [https]
//   return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
// }
