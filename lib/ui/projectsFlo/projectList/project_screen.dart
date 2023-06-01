import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/download_button_lwc.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';

import 'project_screen_tour_keys.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> implements ProjectView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  ProjectPresenter projectPresenter;
  List<ProjectListResponse> listOfProjects = [];

  TutorialCoachMark globalTutorialCoachMark;

  @override
  void initState() {
    super.initState();
    projectPresenter = ProjectPresenter(this);
    projectPresenter.getProjectList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(22.0),
            Text("Projects (${listOfProjects.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  projectPresenter.getProjectList(context);
                },
                children: listOfProjects.map<Widget>((e) => cardViewProjects(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewProjects(ProjectListResponse projectData) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Screens.kProjectDetailScreen, arguments: projectData);
      },
      child: Container(
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
                      image: MemoryImage(Utility.convertMemoryImage(projectData.projectImage)),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: InkWell(
                    onTap: () {
                      if (projectData?.projectWebsite == null)
                        onError("Project link not found");
                      else
                        launch("https://${projectData.projectWebsite}");
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      key: projectData.mapOfKeys["projectScreenWebsiteButton"],
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text("${projectData.projectName}", style: textStyle24px500w)),
                      // InkWell(
                      //   onTap: () {
                      //     Utility.launchUrlX(context, projectData?.mobileBroucher);
                      //   },
                      //   child: Container(
                      //     width: 30,
                      //     height: 30,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: AppColors.colorPrimary,
                      //     ),
                      //     child: Icon(Icons.download_rounded, color: AppColors.white, size: 16),
                      //   ),
                      // ),
                      DownloadButtonLwc(projectData?.projectId, Constants.BROCHURE, key: projectData.mapOfKeys["projectScreenDownloadButton"],),
                    ],
                  ),
                  verticalSpace(10.0),
                  Text("${projectData?.projectLocation}", style: textStyleSubText14px500w),
                ],
              ),
            ),
            verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  void showTour() async {
    bool completed = await Utility.isTourCompleted(Screens.kProjectScreen);
    if (!completed && globalTutorialCoachMark == null) {
      createTutorial();
      await Future.delayed(Duration(milliseconds: 400));
      globalTutorialCoachMark.show(context: context);
    }
  }

  void createTutorial() {
    globalTutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: AppColors.colorPrimary,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Create Tutorial findish");
        Utility.setTourCompleted(Screens.kProjectScreen);
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "projectScreenWebsiteButton",
        keyTarget: projectScreenWebsiteButton,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Go to project website", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "projectScreenDownloadButton",
        keyTarget: projectScreenDownloadButton,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Project Brochure Download", style: textStyleWhite14px600w),
                ],
              );
            },
          ),

        ],
      ),
    );

    return targets;
  }


  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProjectListFetched(List<ProjectListResponse> projectListResponse) {
    listOfProjects.clear();
    listOfProjects.addAll(projectListResponse);

    if (listOfProjects.isNotEmpty) {
      listOfProjects.first.mapOfKeys.addAll({
        "projectScreenWebsiteButton": projectScreenWebsiteButton,
        "projectScreenDownloadButton": projectScreenDownloadButton,
      });

      showTour();
    }

    setState(() {});
  }
}
