import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/add_lead_view.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/model/create_lead_request.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/model/pick_list_response.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/model/project_configuration_response.dart';
import 'package:piramal_channel_partner/ui/lead/lead_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

import 'helper/add_lead_constants.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({Key key}) : super(key: key);

  @override
  _AddLeadScreenState createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> implements AddLeadView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  final List<String> projectList = ["Piramal Aranya", "Piramal Vaikunth", "Piramal Revanta", "Piramal Mahalaxm"];
  final List<String> configurationList = ["1 BHK", "2 BHK", "3 BHK"];
  final List<String> locationList = ["Mumbai"];
  final List<String> budgetList = [
    "0.75 Cr - 1.0 Cr",
    "1.0 Cr - 1.5 Cr",
    "1.5 Cr - 2.0 Cr",
    "2.0 Cr - 2.5 Cr",
    "4 Cr - 6 Cr",
    "6 Cr – 8 Cr",
    "8 Cr - 10 Cr",
    "10 Cr - 12 Cr",
    "Above 12 Cr",
    "Other",
  ];
  final List<String> subUrbanList = [""];
  List<String> listOfCpLeadStatus = [""];

  CreateLeadRequest createLeadRequest = CreateLeadRequest();
  LeadPresenter leadPresenter;
  bool hideKeyboard = false;

  @override
  void initState() {
    super.initState();
    leadPresenter = LeadPresenter(this);
    leadPresenter.fetchDropDownValues(context);
    createLeadRequest.projectInterested = projectList[0];
    createLeadRequest.configuration = configurationList[0];
    createLeadRequest.budget = budgetList[0];
    createLeadRequest.location = locationList[0];

    DateTime date = DateTime.now();
    createLeadRequest.dateofvisit = "${date.year}-${date.month}-${date.day}";
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.18;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragStart: (x) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.screenBackgroundColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(22.0),
                Text("Add Lead", style: textStyle24px500w),
                verticalSpace(20.0),
                buildProfileDetailCard("Name of the Customer", "Enter customer name", 1),
                buildProfileDetailCard("Mobile Number", "Enter customer mobile number", 2),
                buildProfileDetailCard("Email Id", "Enter customer email address", 3),
                buildProfileDetailCard2("Interested In", "Piramal Mahalaxmi", projectList, AddLeadConstant.INTERESTED_DROP),
                buildProfileDetailCard2("Configuration", "2 Bedroom", configurationList, AddLeadConstant.CONFIGURATION_DROP),
                buildProfileDetailCard2("Budget", "INR 5 Crore ", budgetList, AddLeadConstant.BUDGET_DROP),
                buildProfileDetailCard2("Location", "Navi Mumbai", locationList, AddLeadConstant.LOCATION_DROP),
                buildProfileDetailCard2("Sub Urban", "", subUrbanList, AddLeadConstant.SUB_URBAN_DROP),
                buildProfileDetailCard2("CP Lead Status", "", listOfCpLeadStatus, AddLeadConstant.CP_LEAD_STATUS_DROP),
                buildProfileDetailCard3("Date of Visit", "27 October 2021"),
                Center(
                  child: PmlButton(
                    width: Utility.screenWidth(context) * 0.55,
                    text: "Submit",
                    onTap: () {
                      leadPresenter.createLead(context, createLeadRequest);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String hint, int captureNo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$mText",
            style: textStyle14px500w,
          ),
          TextFormField(
            // obscureText: true,
            textAlign: TextAlign.left,
            // controller: otpTextController,
            maxLines: 1,
            // inputFormatters: [LengthLimitingTextInputFormatter(4)],
            textCapitalization: TextCapitalization.none,
            style: subTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "$hint",
              hintStyle: subTextStyle,
              isDense: true,
              suffixStyle: TextStyle(color: AppColors.textColor),
            ),
            onChanged: (String val) {
              hideKeyboard = false;
              if (captureNo == 1) {
                createLeadRequest.name = val;
              } else if (captureNo == 2) {
                createLeadRequest.mobilenumber = val;
              } else if (captureNo == 3) {
                createLeadRequest.emailID = val;
              }
            },
          ),
          // Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }

  Container buildProfileDetailCard2(String mText, String sText, List dropDownValue, int captureNo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$mText", style: textStyle14px500w),
              Stack(
                children: [
                  Positioned(
                    top: 10.0,
                    child: Text("${getItemByCaptureNo(captureNo)}", style: textStyleSubText14px500w),
                  ),
                  Container(
                    width: Utility.screenWidth(context) * .70,
                    height: 35.0,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: <String>[...dropDownValue].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        hideKeyboard = true;
                        switch (captureNo) {
                          case AddLeadConstant.INTERESTED_DROP:
                            leadPresenter.getProjectConfigurationByProject(context, value);
                            createLeadRequest.projectInterested = value;
                            break;
                          case AddLeadConstant.CONFIGURATION_DROP:
                            createLeadRequest.configuration = value;
                            break;
                          case AddLeadConstant.BUDGET_DROP:
                            createLeadRequest.budget = value;
                            break;
                          case AddLeadConstant.LOCATION_DROP:
                            createLeadRequest.location = value;
                            break;
                          case AddLeadConstant.SUB_URBAN_DROP:
                            createLeadRequest.subUrban = value;
                            break;
                        }

                        setState(() {});
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  String getItemByCaptureNo(int captureNo) {
    switch (captureNo) {
      case 1:
        return createLeadRequest.projectInterested;
        break;
      case 2:
        return createLeadRequest.configuration;
        break;
      case 3:
        return createLeadRequest.budget;
        break;
      case 4:
        return createLeadRequest.location;
        break;
      case 5:
        return createLeadRequest.subUrban;
        break;
      default:
        return "";
    }
  }

  Container buildProfileDetailCard3(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$mText",
                style: textStyle14px500w,
              ),
              Text("${createLeadRequest.dateofvisit}", style: textStyleSubText14px500w),
            ],
          ),
          Spacer(),
          PmlButton(
            height: 35,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(Images.kIconCpEventCalender, color: AppColors.white),
            ),
            onTap: () {
              _selectDate();
            },
          )
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      createLeadRequest.dateofvisit = "${picked.year}-${picked.month}-${picked.day}";
      setState(() {});
    }
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onLeadCreated() {
    Utility.showSuccessToastB(context, "Lead created");
    Navigator.pop(context, true);
  }

  @override
  void onPickListFetched(List<PickListResponse> pickList) {
    pickList.forEach((element) => addListByPickListType(element));
    setState(() {});
  }

  void addListByPickListType(PickListResponse element) {
    switch (element?.fieldName) {
      case AddLeadConstant.CONFIGURATION_C:
        _v(configurationList, element.values);
        break;
      case AddLeadConstant.PROJECT_INTERESTED_C:
        _v(projectList, element.values);
        if (projectList.isNotEmpty) {
          createLeadRequest.projectInterested = projectList[0];
          leadPresenter.getProjectConfigurationByProject(context, createLeadRequest.projectInterested);
        }
        break;
      case AddLeadConstant.BUDGET_C:
        _v(budgetList, element.values);
        break;
      case AddLeadConstant.LOCATION_C:
        _v(locationList, element.values);
        break;
      case AddLeadConstant.CP_LEAD_STATUS:
        _v(listOfCpLeadStatus, element.values);
        if (listOfCpLeadStatus.isNotEmpty) createLeadRequest.subUrban = listOfCpLeadStatus.first;
        break;
      case AddLeadConstant.SUB_URBAN_C:
        _v(subUrbanList, element.values);
        if (subUrbanList.isNotEmpty) createLeadRequest.subUrban = subUrbanList[0];

        break;
    }
  }

  void _v(List<String> list, String val) {
    if (val != null && val.isNotEmpty) {
      list.clear();
      List<String> stringList = val.split(",").toList();
      stringList.removeLast();
      list.addAll(stringList);
    }
  }

  void removeFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void onProjectConfigurationFetched(List<ProjectConfigurationResponse> list) {
    list.forEach((projectConfig) {
      if (projectConfig?.fieldName == AddLeadConstant.BUDGET_I) {
        List<String> bList = projectConfig?.values?.split(",") ?? [];
        if (bList.isNotEmpty) bList.removeLast();
        budgetList.clear();
        budgetList.addAll(bList);
        createLeadRequest.budget = budgetList.isEmpty ? "" : budgetList[0];
      } else if (projectConfig?.fieldName == AddLeadConstant.CONFIGURATION_I) {
        List<String> cList = projectConfig?.values?.split(",") ?? [];
        if (cList.isNotEmpty) cList.removeLast();
        configurationList.clear();
        configurationList.addAll(cList);
        createLeadRequest.configuration = configurationList.isEmpty ? "" : configurationList[0];
      }
    });

    setState(() {});
  }
}
