import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/add_lead_view.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/model/create_lead_request.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/model/pick_list_response.dart';
import 'package:piramal_channel_partner/ui/lead/lead_presenter.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class EditLeadScreen extends StatefulWidget {
  final AllLeadResponse allLeadResponse;

  const EditLeadScreen(this.allLeadResponse, {Key key}) : super(key: key);

  @override
  _EditLeadScreenState createState() => _EditLeadScreenState();
}

class _EditLeadScreenState extends State<EditLeadScreen> implements AddLeadView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  final List<String> projectList = ["Piramal Aranya", "Piramal Vaikunth", "Piramal Revanta", "Piramal Mahalaxm"];
  final List<String> configurationList = ["1 BHK", "2 BHK", "3 BHK"];
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

  final List<String> locationList = ["Mumbai"];

  CreateLeadRequest createLeadRequest = CreateLeadRequest();
  LeadPresenter leadPresenter;

  @override
  void initState() {
    super.initState();
    leadPresenter = LeadPresenter(this);
    leadPresenter.fetchDropDownValues(context);

    AllLeadResponse response = widget.allLeadResponse;
    createLeadRequest.name = response.name;
    createLeadRequest.mobilenumber = response.mobileNumber;
    createLeadRequest.projectInterested = response.projectInterested;
    createLeadRequest.configuration = response.configuration;
    createLeadRequest.budget = response.budget;
    createLeadRequest.location = response.location;
    createLeadRequest.accountId = response.sfdcid;

    // for mate  time
    String date = response?.dateofvisit;
    if (date != null) date = date.split("T").first;
    createLeadRequest.dateofvisit = date;
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.18;
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            verticalSpace(22.0),
            Text("Add Lead", style: textStyle24px500w),
            verticalSpace(20.0),
            buildProfileDetailCard("Name of the Customer", "Enter customer name", 0),
            buildProfileDetailCard("Mobile Number", "Enter customer mobile number", 1),
            buildProfileDetailCard2("Interested In", "Piramal Mahalaxmi", projectList, 2),
            buildProfileDetailCard2("Configuration", "2 Bedroom", configurationList, 3),
            buildProfileDetailCard2("Budget", "INR 5 Crore ", budgetList, 4),
            buildProfileDetailCard2("Location", "Navi Mumbai", locationList, 5),
            buildProfileDetailCard3("Date of Visit", "27 October 2021"),
            Center(
              child: PmlButton(
                width: Utility.screenWidth(context) * 0.55,
                text: "Submit",
                onTap: () {
                  leadPresenter.updateLead(context, createLeadRequest);
                },
              ),
            )
          ],
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
            initialValue: getItemByCaptureNo(captureNo),
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
              if (captureNo == 0) {
                createLeadRequest.name = val;
              } else if (captureNo == 1) {
                createLeadRequest.mobilenumber = val;
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
      padding: EdgeInsets.only(left: 20.0, top: 18.0, bottom: 18.0),
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
                  Opacity(
                    opacity: 0.0,
                    child: Container(
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
                          switch (captureNo) {
                            case 2:
                              createLeadRequest.projectInterested = value;
                              break;
                            case 3:
                              createLeadRequest.configuration = value;
                              break;
                            case 4:
                              createLeadRequest.budget = value;
                              break;
                            case 5:
                              createLeadRequest.location = value;
                              break;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Positioned(right: 0, child: Icon(Icons.arrow_drop_down)),
                ],
              )
            ],
          ),
          horizontalSpace(30.0),
        ],
      ),
    );
  }

  String getItemByCaptureNo(int captureNo) {
    switch (captureNo) {
      case 0:
        return createLeadRequest?.name;
        break;
      case 1:
        return createLeadRequest?.mobilenumber;
        break;
      case 2:
        return createLeadRequest?.projectInterested;
        break;
      case 3:
        return createLeadRequest?.configuration;
        break;
      case 4:
        return createLeadRequest?.budget;
        break;
      case 5:
        return createLeadRequest?.location;
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
    pickList.forEach((element) => _(element));
    setState(() {});
  }

  void _(PickListResponse element) {
    switch (element?.fieldName) {
      case "Configuration__c":
        _v(configurationList, element.values);
        break;
      case "Project_Interested__c":
        _v(projectList, element.values);
        break;
      case "Budget__c":
        _v(budgetList, element.values);
        break;
      case "Location__c":
        _v(locationList, element.values);
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
}