import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_download_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/download_button.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';

class ProjectDetailDownloadPage extends StatelessWidget {
  final List<ProjectDownloadResponse> projectDownloadResponse = [];

  ProjectDetailDownloadPage(List<ProjectDownloadResponse> projectDownloadResponse, {Key key}) : super(key: key) {
    if (projectDownloadResponse != null) {
      this.projectDownloadResponse.clear();
      this.projectDownloadResponse.addAll(projectDownloadResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          line(),
          // cardViewListDownloadsV2(
          //   Image.asset(Images.kIconHome, color: AppColors.colorSecondary, width: 20.0),
          //   "Masterplan",
          //   projectDownloadResponse[0],
          //   projectDownloadResponse[0].masterPlanLink,
          //   Constants.MASTER_PLAN,
          // ),

          cardViewListDownloadsV2(
            Image.asset(Images.kIconBrochure, color: AppColors.colorSecondary, width: 15.0),
            "Brochure",
            projectDownloadResponse[0],
            projectDownloadResponse[0].brochure,
            Constants.BROCHURE,
          ),

          // for (int i = 2; i < projectDownloadResponse.length; i++) cardViewListDownloads(context, projectDownloadResponse[i]),
          // ...projectDownloadResponse.map<Widget>((e) => cardViewListDownloads(e)).toList(),
        ],
      ),
    );
  }

  cardViewListDownloadsV2(Image icon, String name, ProjectDownloadResponse response, String link, String identifier) {
    return Column(
      children: [
        verticalSpace(20.0),
        Row(
          children: [
            icon,
            horizontalSpace(30.0),
            Text("$name", style: textStyle20px500w),
            Spacer(),

            //whats app and download
            WhatsAppButton(response.siteManagerMobile),
            horizontalSpace(8.0),
            DownloadButton("${response?.projectId}", "$identifier"),
          ],
        ),
        verticalSpace(20.0),
        line(),
      ],
    );
  }

  cardViewListDownloads(BuildContext context, ProjectDownloadResponse response) {
    return Column(
      children: [
        verticalSpace(20.0),
        Row(
          children: [
            Image.asset(Images.kIconPlan, width: 15.0),
            horizontalSpace(30.0),
            Text("${response?.towerName ?? "Not Available"}\nTypical Floor Plan", style: textStyle14px500w),
            Spacer(),

            //whats app and download
            WhatsAppButton(response?.message),
            horizontalSpace(8.0),
            DownloadButton("${response.towerID}", Constants.FLOOR_PLAN),
          ],
        ),
        verticalSpace(20.0),
        line(),
      ],
    );
  }
}
