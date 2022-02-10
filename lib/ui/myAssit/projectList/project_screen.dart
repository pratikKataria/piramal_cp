import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

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
              child: ListView(
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
                  Text("South Mumbai - India", style: textStyleSubText14px500w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProjectListFetched(List<ProjectListResponse> projectListResponse) {
    listOfProjects.clear();
    listOfProjects.addAll(projectListResponse);
    setState(() {});
  }
}
