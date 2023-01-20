import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_tower_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailTowerPage extends StatelessWidget {
  final List<ProjectTowerResponse> projectTowerResponse = [];

  ProjectDetailTowerPage(List<ProjectTowerResponse> projectTowerResponse, {Key key}) : super(key: key) {
    if (projectTowerResponse != null) {
      this.projectTowerResponse.clear();
      this.projectTowerResponse.addAll(projectTowerResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: projectTowerResponse.map<Widget>((e) => cardViewTower(e, context)).toList(),
      ),
    );
  }

  cardViewTower(ProjectTowerResponse response, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            // box-shadow: 0px 10px 30px 0px #0000000D;
            color: AppColors.colorSecondary.withOpacity(0.1),
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: MemoryImage(Utility.convertMemoryImage(response.towerImage)),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                  onTap: () {
                    if (response?.towerWebsite == null) {
                      Utility.showErrorToastB(context, "No link found");
                      return;
                    }

                    launch("https://${response.towerWebsite}");
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    child: Image.asset(Images.kIconRedirect),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${response?.towerName ?? ""}", style: textStyle24px500w),
                Text("${response?.projectName ?? ""}", style: textStyleSubText14px500w),
              ],
            ),
          ),
          verticalSpace(10.0),
        ],
      ),
    );
  }
}
