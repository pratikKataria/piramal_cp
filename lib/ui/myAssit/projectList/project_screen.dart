import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'project_screen_tour_keys.dart';

class ProjectScreenMyAssist extends StatefulWidget {
  const ProjectScreenMyAssist({Key key}) : super(key: key);

  @override
  _ProjectScreenMyAssistState createState() => _ProjectScreenMyAssistState();
}

class _ProjectScreenMyAssistState extends State<ProjectScreenMyAssist> implements ProjectView {
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
                tourKey: myProfileProjectCard,
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
        Navigator.pushNamed(context, Screens.kMyAssistScreen, arguments: projectData.projectId);
      },
      child: Container(
        key: projectData.key,
        margin: EdgeInsets.only(bottom: 18.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${projectData.projectName}", style: textStyleRegular18pxW500),
                  Text("${projectData.projectLocation}", style: textStyleSubText14px500w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTour() async {
    bool completed = await Utility.isTourCompleted(Screens.kMyAssistProjectScreen);
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
      hideSkip: false,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Create Tutorial findish");
        Utility.setTourCompleted(Screens.kMyAssistProjectScreen);
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
          Utility.setTourCompleted(Screens.kSettingsScreen);
   return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "myProfileProjectCard",
        keyTarget: myProfileProjectCard,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Select project to know details about.", style: textStyleWhite14px600w),
                  Text("    \u2022 Relationship Manager", style: textStyleWhite14px500w),
                  Text("    \u2022 Team Lead", style: textStyleWhite14px500w),
                  Text("    \u2022 Channel Head", style: textStyleWhite14px500w),
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
      listOfProjects.first.key = myProfileProjectCard;
      showTour();
    }
    setState(() {});
  }
}
