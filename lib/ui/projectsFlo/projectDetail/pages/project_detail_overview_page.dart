import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailOverviewPage extends StatelessWidget {
  final ProjectOverviewResponse projectOverviewResponse;

  ProjectDetailOverviewPage(this.projectOverviewResponse);

  @override
  Widget build(BuildContext context) {
    // print("Project Detail Overview page context ${projectOverviewResponse.toJson()}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ListView(
            children: [
              Text(
                "${projectOverviewResponse?.projectDescription ?? ""}",
                style: textStyle14px500w20H,
              ),
              verticalSpace(10.0),
              line(),
              verticalSpace(10.0),
              Row(
                children: [
                  Text("Website: ", style: textStyleSubText14px500w),
                  InkWell(
                    onTap: () async {
                      await launch(projectOverviewResponse?.website ?? "", forceSafariVC: false);
                    },
                    child: Text("${projectOverviewResponse?.website ?? ""} ↗ ", style: textStylePrimary14px500w),
                  ),
                ],
              ),
              verticalSpace(10.0),
              Row(
                children: [
                  Text("3D Tour:  ", style: textStyleSubText14px500w),
                  InkWell(
                      onTap: () async {
                        String url = projectOverviewResponse?.threeDtoururl ?? "";
                        if (url.isNotEmpty) {
                          await launch(url ?? "", forceSafariVC: false);
                        }
                      },
                      child: Text("${projectOverviewResponse?.threeDtoururl ?? "Not found"} ↗", style: textStylePrimary14px500w)),
                ],
              ),
              InkWell(
                onTap: () async {
                  String url = projectOverviewResponse?.projectmap ?? "";
                  if (url.isNotEmpty) {
                    await launch(url ?? "", forceSafariVC: false);
                  }
                },
                child: Image.asset(Images.kImgPlaceholderMap, height: 178),
              ),
              verticalSpace(10.0),
              InkWell(
                onTap: () async {},
                child: Image.memory(Utility.convertMemoryImage(projectOverviewResponse?.projectphotos)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void showLargeImage(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[],
        );
      },
    );
  }
}
