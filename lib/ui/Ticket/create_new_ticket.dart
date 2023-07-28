import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/case_subtype_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_request.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/reopen_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_category_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_picklist_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/ticket_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/extension.dart';
import 'package:piramal_channel_partner/widgets/hrm_input_fields_dummy.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

import 'ticket_presenter.dart';

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({Key key}) : super(key: key);

  @override
  State<CreateNewTicket> createState() => _CreateNewTicketState();
}

class _CreateNewTicketState extends State<CreateNewTicket> implements TicketView {
  // List<String> listOfSubCategory = [];
  // List<String> listOfCategory = [];
  List<String> listOfTypes = [];
  List<String> listOfSubTypes = [];

  TicketPresenter presenter;
  String name;

  CreateTicketRequest createTicketRequest = CreateTicketRequest();

  @override
  void initState() {
    super.initState();
    presenter = TicketPresenter(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.getTicketPicklistValues(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(20.0),
            Text("Type", style: textStyle14px500w),
            verticalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0.0,
                      child: Text("${createTicketRequest.caseType}".notNullEmpty, style: textStyleSubText14px500w),
                    ),
                    Container(
                      width: Utility.screenWidth(context) * .70,
                      height: 35.0,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 34.0,
                        items: <String>[...listOfTypes].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            createTicketRequest.caseType = value;
                            createTicketRequest.caseSubType = null;
                            presenter.getTicketSubType(context, value);
                            setState(() {});
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            verticalSpace(20.0),
            Text("Sub Type", style: textStyle14px500w),
            verticalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0.0,
                      child: Text("${createTicketRequest.caseSubType}".notNullEmpty, style: textStyleSubText14px500w),
                    ),
                    Container(
                      width: Utility.screenWidth(context) * .70,
                      height: 35.0,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 34.0,
                        items: <String>[...listOfSubTypes].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          createTicketRequest.caseSubType = value;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            verticalSpace(20.0),

            Text("Description", style: textStyle14px500w),
            Container(
              height: 45,
              color: AppColors.attachmentBg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  horizontalSpace(10.0),
                  Expanded(
                    child: TextFormField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      // controller: emailPhoneTextController,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.none,
                      style: textStyle14px500w,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type description here ...",
                        hintStyle: textStyle14px500w,
                        suffixStyle: textStyle14px500w,
                        isDense: true,
                      ),
                      onChanged: (String val) {
                        createTicketRequest.description = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(30.0),
            Text("Attachment", style: textStyle14px500w),
            HrmInputFieldDummy(
                    // textController: dobTextController,
                    headingText: "",
                    text: name == null ? "Add img, pdf or xls" : name,
                    mandate: true)
                .onClick(() async {
              try {
                List<String> fileAndName = await Utility.pickFile(context);
                createTicketRequest.attachFile = fileAndName[0].isEmpty ? null : fileAndName[0];
                name = fileAndName[1].isEmpty ? null : fileAndName[1];

                // Split the file name by '.' to separate the name and extension
                List<String> parts = name.split('.');
                createTicketRequest.fileType = parts.last;
              } catch (e) {
                createTicketRequest.attachFile = null;
                name = null;
              }
              setState(() {});
            }),
            verticalSpace(30.0),
            loginButton("Create Ticket"),
          ],
        ),
      ),
    );
  }

  PmlButton loginButton(String text) {
    return PmlButton(
      text: "$text",
      onTap: () {
        presenter.createTickets(context, createTicketRequest);
      },
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    // listOfSubCategory.clear();
    // if (rmDetailResponse.values.isNotEmpty) listOfSubCategory.addAll(rmDetailResponse.values.split(",").toList());
    // if (listOfSubCategory.isNotEmpty) {
    //   listOfSubCategory.removeLast();
    //   createTicketRequest.category = listOfSubCategory.first;
    // }
    // setState(() {});
  }

  @override
  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    // listOfCategory.clear();
    // if (rmDetailResponse.values.isNotEmpty) listOfCategory.addAll(rmDetailResponse.values.split(","));
    // if (listOfCategory.isNotEmpty) {
    //   listOfCategory.removeLast();
    //
    //   createTicketRequest.source = listOfCategory.first;
    //   presenter.getTicketSubCategoryWithLoader(context, createTicketRequest.source);
    // }
    // setState(() {});
  }

  @override
  void onTicketCreated(CreateTicketResponse rmDetailResponse) {
    Navigator.pop(context);
    // headerTextController.value = Screens.kTicketsScreen; // close pop up
    Utility.showSuccessToastB(context, "Ticket Created");
    // _presenter.getTicketsWithoutLoader(context);
    // clearTicketDesc();
    setState(() {});
  }

  @override
  void onTicketFetched(TicketResponse rmDetailResponse) {}

  @override
  void onTicketReopened(ReopenResponse rmDetailResponse) {}

  @override
  void onTicketPicklistFetched(TicketPicklistResponse rmDetailResponse) {
    listOfSubTypes.clear();
    listOfTypes.clear();
    // listOfCategory.clear();
    // listOfSubCategory.clear();
    setState(() {});

    rmDetailResponse.fieldList.forEach((element) {
      if (element.fieldName == "Case Type") {
        List<String> tempListOfValues = element.values.split(",");
        tempListOfValues.removeLast();
        listOfTypes.addAll(tempListOfValues);
      }

      if (element.fieldName == "Case Origin") {
        List<String> tempListOfValues = element.values.split(",");
        tempListOfValues.removeLast();
        // listOfCategory.addAll(tempListOfValues);
      }
    });

    if (listOfTypes.isNotEmpty) {
      presenter.getTicketSubType(context, listOfTypes[0]);
      createTicketRequest.caseType = listOfTypes.first;
    }

    // if (listOfCategory.isNotEmpty) {
    //   presenter.getTicketSubCategory(context, listOfCategory[0]);
    //   createTicketRequest.source = listOfCategory.first;
    // }

    setState(() {});
  }

  @override
  void caseSubTypeResponse(CaseSubtypeResponse rmDetailResponse) {
    listOfSubTypes.clear();
    if (rmDetailResponse.values != null) {
      List<String> tempListOfValues = rmDetailResponse.values.split(",");
      tempListOfValues.removeLast();
      listOfSubTypes.addAll(tempListOfValues);
      createTicketRequest.caseSubType = listOfSubTypes.first;
    }

    setState(() {});
  }
}


/*   Text("Category", style: textStyle14px500w),
            verticalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0.0,
                      child: Text("${createTicketRequest.source}".notNullEmpty, style: textStyleSubText14px500w),
                    ),
                    Container(
                      width: Utility.screenWidth(context) * .70,
                      height: 35.0,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 34.0,
                        items: <String>[...listOfCategory].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            createTicketRequest.source = value;
                            createTicketRequest.category = null;
                            listOfSubCategory.clear();

                            presenter.getTicketSubCategory(context, value);
                            setState(() {});
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            verticalSpace(20.0),
            Text("Sub Category", style: textStyle14px500w),
            verticalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0.0,
                      child: Text("${createTicketRequest.category}".notNullEmpty, style: textStyleSubText14px500w),
                    ),
                    Container(
                      width: Utility.screenWidth(context) * .70,
                      height: 35.0,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 34.0,
                        items: <String>[...listOfSubCategory].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            createTicketRequest.category = value;

                            setState(() {});
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),*/
