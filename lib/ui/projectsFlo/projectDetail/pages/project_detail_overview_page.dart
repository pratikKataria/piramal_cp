import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piramal_channel_partner/api/api_controller.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/cached_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailOverviewPage extends StatelessWidget {
  final ProjectOverviewResponse projectOverviewResponse;

  ProjectDetailOverviewPage(this.projectOverviewResponse);

  @override
  Widget build(BuildContext context) {
    // print("Project Detail Overview page context ${projectOverviewResponse.toJson()}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
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
          Wrap(
            runSpacing: 20.0,
            spacing: 20.0,
            children: [
              if (projectOverviewResponse?.projectBottomImagesList?.isNotEmpty ?? false)
                for (String image in projectOverviewResponse.projectBottomImagesList)
                  InkWell(
                      onTap: () {
                        showLargeImage(context, image);
                      },
                      child: CachedImageWidget(
                        imageUrl: image,
                        width: 95,
                        height: 95,
                        radius: 5.0,
                      ))
            ],
          )
        ],
      ),
    );
  }

  static void showLargeImage(BuildContext context, String image) async {
    bool downloaded = false;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 4.0),
          actions: <Widget>[
            Stack(
              children: [
                CachedImageWidget(
                  width: Utility.screenWidth(context),
                  height: 200.0,
                  imageUrl: image,
                  radius: 0.0,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      bool permissionIsGranted = await Permission.storage.request().isGranted;
                      if (!permissionIsGranted) {
                        Utility.showErrorToastB(context, "Storage permission denied");
                        return;
                      }

                      Random random = new Random();
                      int randomNumber = random.nextInt(100);
                      var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_PICTURES);
                      String fileName = "$path/${randomNumber}_pml.jpg";

                      try {
                        Response response = await ApiController.getInstance().download(image);
                        File file = File(fileName);
                        var raf = file.openSync(mode: FileMode.write);
                        raf.writeFromSync(response.data);
                        await raf.close();

                        downloaded = true;
                        await Navigator.pop(context);
                      } catch (e) {
                        Utility.showErrorToastB(context, e.toString());
                        print(e);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.black.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(Images.kIconDownload),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (downloaded) Utility.showSuccessToastB(context, "Image downloaded at Storage/Picture", duration: 6);
  }
}
