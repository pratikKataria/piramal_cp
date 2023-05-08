import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/lead/lead_presenter.dart';
import 'package:piramal_channel_partner/ui/lead/lead_view.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'lead_tour_keys_bottom_navigation.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({Key key}) : super(key: key);

  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> implements LeadView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  LeadPresenter leadPresenter;
  List<AllLeadResponse> listOfLeads = [];
  List<AllLeadResponse> projectCachedBuffer = [];
  List<String> projectList = [""];
  String projectFilterVal = "";

  TutorialCoachMark globalTutorialCoachMark;

  @override
  void initState() {
    super.initState();
    leadPresenter = LeadPresenter(this);
    leadPresenter.getLeadList(context);
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.18;
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      floatingActionButton: PmlButton(
        key: leadScreenAddLead,
        height: 45.0,
        width: 45.0,
        color: AppColors.black,
        child: Icon(Icons.add, size: 24, color: AppColors.screenBackgroundColor),
        onTap: () async {
          var created = await Navigator.pushNamed(context, Screens.kAddLeadScreen);
          if (created is bool && created) leadPresenter.getLeadListS(context);
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(22.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Leads", style: textStyle24px500w),
                buildProfileDetailCard2("mText", "", projectList),
              ],
            ),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  leadPresenter.getLeadList(context);
                },
                children: listOfLeads.map<Widget>((e) => cardViewLead(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildProfileDetailCard2(String mText, String sText, List dropDownValue) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Stack(
            children: [
              Container(
                width: Utility.screenWidth(context) * .30,
                margin: EdgeInsets.only(top: 4.5),
                child: Text(projectFilterVal, style: textStyleSubText14px500w, overflow: TextOverflow.ellipsis),
              ),
              Container(
                width: Utility.screenWidth(context) * .30,
                height: 20.0,
                key: leadScreenSelectProjectFilter,
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  hint: Text("${projectFilterVal.isEmpty ? "Select project" : ""}", style: textStyle12px500w),
                  items: <String>[...dropDownValue].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: textStyle12px500w),
                    );
                  }).toList(),
                  onChanged: (value) {
                    projectFilterVal = value;

                    //list filtering by project
                    if (projectFilterVal != null && projectFilterVal.isNotEmpty) {
                      listOfLeads.clear();
                      projectCachedBuffer.forEach((lead) {
                        if (projectFilterVal == lead.projectInterested) listOfLeads.add(lead);
                      });
                    }

                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ),
        horizontalSpace(10.0),
        if (projectFilterVal.isNotEmpty)
          PmlButton(
            height: 24.0,
            width: 24.0,
            color: AppColors.white,
            child: Icon(Icons.close, size: 16),
            onTap: () async {
              projectFilterVal = "";
              listOfLeads.clear();
              listOfLeads.addAll(projectCachedBuffer);

              setState(() {});
            },
          ),
      ],
    );
  }

  cardViewLead(AllLeadResponse leadData) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
          Row(
            children: [
              /*      ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Container(
                  height: 46,
                  width: 46,
                  child: Image.asset(Images.kImgPlaceholder, fit: BoxFit.fill),
                ),
              ),
              horizontalSpace(14.0),*/
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${leadData.name}",
                      style: textStyle20px500w,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("${leadData.mobileNumber}", style: textStyleSubText14px500w),
                  ],
                ),
              ),
              Spacer(),
              PmlButton(
                height: 32.0,
                width: 32.0,
                key: leadData.mapOfKeys["leadScreenCardViewEditButton"],
                color: AppColors.screenBackgroundColor,
                child: Icon(Icons.edit, size: 16),
                onTap: () async {
                  var created = await Navigator.pushNamed(context, Screens.kEditLeadScreen, arguments: leadData);
                  if (created is bool && created) leadPresenter.getLeadListS(context);
                },
              ),
              horizontalSpace(10.0),
              PmlButton(
                height: 32.0,
                width: 32.0,
                key: leadData.mapOfKeys["leadScreenCardViewDeleteButton"],
                color: AppColors.colorPrimaryLight,
                child: Icon(Icons.delete, color: AppColors.colorPrimary, size: 16),
                onTap: () => leadPresenter.deleteLead(context, leadData),
              ),
            ],
          ),
          line(),
          Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.chipColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text("${leadData.projectInterested}", style: textStyle14px500w),
              ),
              horizontalSpace(10.0),
              if (leadData.cpLeadStatus != null && leadData.cpLeadStatus.isNotEmpty) Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.green,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text("${leadData.cpLeadStatus}", style: textStyleWhite14px600w),
              ),

            ],
          ),

          /* Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                horizontalSpace(10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.chipColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("Piramal Mahalaxmi", style: textStyle14px500w),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  void onAllLeadFetched(List<AllLeadResponse> leadList) {
    listOfLeads.clear();
    projectCachedBuffer.clear();
    listOfLeads.addAll(leadList);
    projectCachedBuffer.addAll(leadList);

    //add projects to project list
    projectList.clear();
    listOfLeads.forEach((lead) {
      bool isProjectAlreadyPresent = projectList.contains(lead.projectInterested);
      if (!isProjectAlreadyPresent) projectList.add(lead.projectInterested);
    });

    if (listOfLeads.isNotEmpty) {
      listOfLeads.first.mapOfKeys.addAll({
        "leadScreenCardViewEditButton": leadScreenCardViewEditButton,
        "leadScreenCardViewDeleteButton": leadScreenCardViewDeleteButton,
      });

      showTour();
    }
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  void showTour() async {
    bool completed = await Utility.isTourCompleted(Screens.kLeadScreen);
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
        Utility.setTourCompleted(Screens.kLeadScreen);
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
        identify: "leadScreenSelectProjectFilter",
        keyTarget: leadScreenSelectProjectFilter,
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
                  Text("Filter leads by project interested.", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "leadScreenCardViewEditButton",
        keyTarget: leadScreenCardViewEditButton,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Edit existing lead details", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "leadScreenCardViewDeleteButton",
        keyTarget: leadScreenCardViewDeleteButton,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Delete existing lead.", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "leadScreenAddLead",
        keyTarget: leadScreenAddLead,
        alignSkip: Alignment.topLeft,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Add new lead by taping on + button.", style: textStyleWhite14px600w),
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
  void onLeadDeleted(AllLeadResponse response) {
    listOfLeads.remove(response);
    setState(() {});
  }
}
