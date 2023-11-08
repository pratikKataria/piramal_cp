import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/case_subtype_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/reopen_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/reopen_ticket_request.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_picklist_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/extension.dart';
import 'package:piramal_channel_partner/widgets/hrm_input_fields_dummy.dart';
import 'package:piramal_channel_partner/widgets/krc_list_v2.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';

import 'model/ticket_category_response.dart';
import 'model/ticket_response.dart';
import 'ticket_presenter.dart';
import 'ticket_view.dart';
import 'dart:math' as math;

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with SingleTickerProviderStateMixin implements TicketView {
  AnimationController menuAnimController;
  TabController _tabController;
  TicketPresenter _presenter;
  TextEditingController _textEditingController = TextEditingController();
  List<OpenCasesList> openTickets = [];
  List<ClosedCasesList> closedTickets = [];

  List<String> category = [""];
  List<String> subCategory = [""];
  ValueNotifier<List<String>> valueNotifier = ValueNotifier([""]);
  String val2;
  bool ascending = true;

  ReopenTicketRequest _reopenTicketRequest = ReopenTicketRequest();

  @override
  void initState() {
    _presenter = TicketPresenter(this);
    _presenter.getTickets(context);

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() async {
      await Future.delayed(Duration(milliseconds: 400));

      if (_tabController.index == 1 && closedTickets.isNotEmpty) {
        //Check for Active Feedback Form

        ClosedCasesList feedbackDataList = closedTickets.firstWhere((element) => element.showFeedbackForm == true, orElse: () => ClosedCasesList());
        if (feedbackDataList.showFeedbackForm == true) {
          feedbackPopUp(feedbackDataList);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, Screens.kCreateTicketsScreen);
          _presenter.getTicketsWithoutLoader(context);
        },
        backgroundColor: AppColors.colorPrimary,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          verticalSpace(10.0),
          buildTabs(),
          verticalSpace(8.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: Text("Sort Date", style: textStyle14px500w)),
                Icon(ascending ? Icons.arrow_upward : Icons.arrow_downward, color: AppColors.colorSecondary),
                horizontalSpace(20.0),
              ],
            ),
          ).onClick(() {
            if (ascending) {
              openTickets.sort();
              closedTickets.sort();
            } else {
              openTickets = openTickets.reversed.toList();
              closedTickets = closedTickets.reversed.toList();
            }

            ascending = !ascending;
            setState(() {});
          }),
          verticalSpace(8.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                if (openTickets.isEmpty)
                  RefreshListView(
                    onRefresh: () {
                      _presenter.getTickets(context);
                    },
                    children: [
                      Container(height: Utility.screenHeight(context) * 0.3),
                      Center(child: Text("No Tickets Present")),
                    ],
                  ),
                if (openTickets.isNotEmpty)
                  RefreshListView(
                    onRefresh: () {
                      _presenter.getTickets(context);
                    },
                    children: [
                      ...openTickets
                          .map((e) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                color: AppColors.screenBackgroundColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    verticalSpace(12.0),
                                    Text("Case No: ${e.caseNumber}", style: textStyle12px500w),
                                    verticalSpace(4.0),
                                    Text("Description: ${e.detailCaseRemarks == null ? "" : e.detailCaseRemarks}", style: textStyle12px500w),
                                    verticalSpace(4.0),
                                    Wrap(
                                      children: [
                                        Text("Created On", style: textStyle12px500w),
                                        Text(" ${e.createdDate}".notNull, style: textStylePrimary12px500w),
                                        // Text(" At", style: textStyleBlack10px500w),
                                        // Text(" ${e.timeData}".notNull, style: textStylePrimary10px500w),
                                        Text(" | OPEN", style: textStylePrimary10px500w),
                                      ],
                                    ),
                                    verticalSpace(10.0),
                                    if (e.type != null) ...[
                                      Text("Type", style: textStyle12px500w),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            ...e.type
                                                .split(";")
                                                .map((e) => Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                                    margin: EdgeInsets.only(right: 10.0),
                                                    color: AppColors.colorSecondary,
                                                    child: Text("$e".notNull, style: textStyleWhite12px500w)))
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                      verticalSpace(10.0),
                                    ],
                                    if (e.subType != null) ...[
                                      Text("Sub Type", style: textStyle12px500w),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            ...e.subType
                                                .split(";")
                                                .map((e) => Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                                    margin: EdgeInsets.only(right: 10.0),
                                                    color: AppColors.colorSecondary,
                                                    child: Text("$e".notNull, style: textStyleWhite12px500w)))
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                      verticalSpace(10.0),
                                    ],
                                  ],
                                ),
                              ).onClick(() async {
                                await Navigator.pushNamed(context, Screens.kTicketDetailScreen, arguments: e);
                              }))
                          .toList(),
                    ] /*openTickets.map<Widget>((e) => cardViewTicket(e)).toList()*/,
                  ),
                if (closedTickets.isEmpty)
                  RefreshListView(
                    onRefresh: () {
                      _presenter.getTickets(context);
                    },
                    children: [
                      Container(height: Utility.screenHeight(context) * 0.3),
                      Center(child: Text("No Tickets Present", style: textStyle14px500w)),
                    ],
                  ),
                if (closedTickets.isNotEmpty)
                  RefreshListView(
                    onRefresh: () {
                      _presenter.getTickets(context);
                    },
                    children: [
                      ...closedTickets.map((e) => cardViewTicketClosed(e)).toList(),
                    ] /*closedTickets.map<Widget>((e) => cardViewTicket(e)).toList()*/,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PmlButton fab() {
    return PmlButton(
      width: 105.0,
      onTap: () {
        _modalBottomSheetMenu();
      },
      child: Row(
        children: [
          horizontalSpace(20.0),
          Image.asset(Assets.imagesIcAdd, width: 15.0),
          horizontalSpace(5.0),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text("Ticket", style: textStyleWhite18px600w),
          ),
        ],
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.colorPrimary,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))), color: Colors.red),
      indicatorPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 6.0),
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelStyle: textStyleDark14px500w,
      unselectedLabelColor: AppColors.textColor,
      labelColor: AppColors.white,
      labelStyle: textStyleRegular16px500w,
      onTap: (int index) {
        setState(() {});
      },
      tabs: [
        Tab(
          text: "Open",
        ),
        Tab(
          text: "Close",
        ),
      ],
    );
  }

  cardViewTicketClosed(ClosedCasesList e) {
    return Container(
      color: AppColors.screenBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          verticalSpace(10.0),
          Text("Case No: ${e.caseNumber}", style: textStyle12px500w),
          verticalSpace(4.0),
          Text("Description: ${e.detailCaseRemarks == null ? "" : e.detailCaseRemarks}", style: textStyle12px500w),
          verticalSpace(4.0),
          Wrap(
            children: [
              Text("Created On", style: textStyle12px500w),
              Text(" ${e.createdDate}".notNull, style: textStylePrimary12px500w),
            ],
          ),
          verticalSpace(10.0),
          if (e.type != null) ...[
            Text("Type", style: textStyle12px500w),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...e.type
                      .split(";")
                      .map((e) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          margin: EdgeInsets.only(right: 10.0),
                          color: AppColors.colorSecondary,
                          child: Text("$e".notNull, style: textStyleWhite12px500w)))
                      .toList(),
                ],
              ),
            ),
            verticalSpace(10.0),
          ],
          if (e.subType != null) ...[
            Text("Sub Type", style: textStyle12px500w),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...e.subType
                      .split(";")
                      .map((e) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          margin: EdgeInsets.only(right: 10.0),
                          color: AppColors.colorSecondary,
                          child: Text("$e".notNull, style: textStyleWhite12px500w)))
                      .toList(),
                ],
              ),
            ),
            verticalSpace(10.0),
          ],
          Image.asset(Assets.imagesBtnReopen, height: 50).onClick(() {
            FocusScope.of(context).unfocus();
            reopenTicketDialog(context, e.caseId);
          })
        ],
      ),
    ).onClick(() async {
      await Navigator.pushNamed(context, Screens.kTicketDetailScreen, arguments: OpenCasesList.fromJson(e.toJson()));
    });
  }

  StateSetter setter;

  _modalBottomSheetMenu() {
    clearTicketDesc();
    String val = category.isEmpty ? "" : category.first;
    val2 = subCategory.isEmpty ? "" : subCategory.first;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    setter = setState;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      color: AppColors.cardColorDark2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create Ticket", style: textStyle14px500w),
                          verticalSpace(20.0),
                          emailField(),
                          verticalSpace(20.0),
                          Text("Select Category", style: textStyleWhite14px500w),
                          verticalSpace(6.0),
                          Container(
                            color: AppColors.inputFieldBackgroundColor,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: DropdownButton<String>(
                              value: val,
                              style: textStyleWhite16px600w,
                              dropdownColor: AppColors.inputFieldBackgroundColor,
                              items: category.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {
                                val = _;
                                _presenter.getTicketSubCategoryWithLoader(context, val);
                                setState(() {});
                              },
                            ),
                          ),

                          //select sub category
                          verticalSpace(20.0),
                          Text("Select Sub Category", style: textStyleWhite14px500w),
                          verticalSpace(6.0),

                          if (subCategory.isNotEmpty)
                            ValueListenableBuilder<List<String>>(
                                valueListenable: valueNotifier,
                                builder: (context, snapshot, child) {
                                  print(val2);
                                  return Container(
                                    color: AppColors.inputFieldBackgroundColor,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: DropdownButton<String>(
                                      value: val2,
                                      style: textStyleWhite16px600w,
                                      dropdownColor: AppColors.inputFieldBackgroundColor,
                                      items: snapshot.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        val2 = _;
                                        // _presenter.getTicketSubCategoryWithLoader(context, val);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                }),
                          verticalSpace(20.0),
                          PmlButton(
                            onTap: () {
                              // _presenter.createTickets(context, _textEditingController.text.toString(), val, val2);
                            },
                            text: "Create Ticket",
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  Container emailField() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        // borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("DESC", style: textStyleSubText14px500w),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: _textEditingController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: textStyleSubText14px500w,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "type description here ...",
                hintStyle: textStyleSubText14px500w,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isShowing = false;

  Future<bool> feedbackPopUp(ClosedCasesList feedback) {
    String rating = "2";
    String desc = "";
    bool submitted = false;
    if (isShowing == false) {
      isShowing = true;
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          String reason = "";
          int selectedIconIndex;
          return StatefulBuilder(builder: (context, alertDialogState) {

            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    actions: <Widget>[
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Feedback", style: textStyle14px500w),
                            verticalSpace(20.0),
                            Text("Case No: ${feedback.caseNumber}", style: textStyle14px500w),
                            verticalSpace(4.0),
                            Text("Description: ${feedback.detailCaseRemarks == null ? "" : feedback.detailCaseRemarks}", style: textStyle14px500w),
                            verticalSpace(4.0),
                            Text("Case Remarks: ${feedback.detailCaseRemarks == null ? "" : feedback.detailCaseRemarks}", style: textStyle14px500w),
                            verticalSpace(4.0),
                            Text("Closing Comments: ${feedback.case_Close_Comments == null ? "" : feedback.case_Close_Comments}", style: textStyle14px500w),
                            verticalSpace(4.0),
                            Wrap(
                              children: [
                                Text("Created On", style: textStyle14px500w),
                                Text(" ${feedback.createdDate}".notNull, style: textStylePrimary14px500w),
                                // Text(" At", style: textStyleBlack10px500w),
                                // Text(" ${e.timeData}".notNull, style: textStylePrimary10px500w),
                                Text(" | ${feedback.status}", style: textStylePrimary14px500w),
                              ],
                            ),
                            verticalSpace(10.0),
                            if (feedback.type != null) ...[
                              Text("Type", style: textStyle14px500w),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...feedback.type
                                        .split(";")
                                        .map((e) => Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                            margin: EdgeInsets.only(right: 10.0),
                                            color: AppColors.colorSecondary,
                                            child: Text("$e".notNull, style: textStyleWhite14px500w)))
                                        .toList(),
                                  ],
                                ),
                              ),
                              verticalSpace(10.0),
                            ],
                            if (feedback.subType != null) ...[
                              Text("Sub Type", style: textStyle14px500w),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...feedback.subType
                                        .split(";")
                                        .map((e) => Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                            margin: EdgeInsets.only(right: 10.0),
                                            color: AppColors.colorSecondary,
                                            child: Text("$e".notNull, style: textStyleWhite14px500w)))
                                        .toList(),
                                  ],
                                ),
                              ),
                              verticalSpace(10.0),
                            ],
                            verticalSpace(20.0),
                            Text("Description (Max 1000 characters)", style: textStyle14px500w),
                            verticalSpace(10.0),
                            Container(
                              height: 150.0,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                border: Border.all(color: AppColors.lineColor, width: 1.5),
                              ),
                              child: TextField(
                                style: textStyle14px600w,
                                maxLines: 5,
                                maxLength: 1000,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Write description ...",
                                  hintStyle: textStyle14px500w,
                                  suffixStyle: textStyle14px500w,
                                  isDense: true,
                                ),
                                onChanged: (s) {
                                  desc = s;
                                },
                              ),
                            ),
                            verticalSpace(20.0),
                            Text("Rating", style: textStyle14px500w),
                            verticalSpace(10.0),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    selectedIconIndex = 0;
                                    rating = selectedIconIndex.toString();
                                    alertDialogState((){});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(16.0),
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedIconIndex == 0 ? AppColors.colorPrimary : Colors.grey,
                                    ),
                                    child: Icon(
                                      Icons.sentiment_dissatisfied,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedIconIndex = 1;
                                    rating = selectedIconIndex.toString();
                                    alertDialogState((){});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(16.0),
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedIconIndex == 1 ? AppColors.warm : Colors.grey,
                                    ),
                                    child: Icon(
                                      Icons.sentiment_neutral,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedIconIndex = 2;
                                    rating = selectedIconIndex.toString();
                                    alertDialogState((){});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(16.0),
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedIconIndex == 2 ? AppColors.attendButtonColor : Colors.grey,
                                    ),
                                    child: Icon(
                                      Icons.sentiment_satisfied,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            verticalSpace(20.0),
                            PmlButton(
                              text: "Submit",
                              onTap: () {
                                submitted = true;
                                _presenter.submitFeedback(context, feedback.caseId, rating, desc);
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ).then((value) {
        FocusScope.of(context).unfocus();
        isShowing = false;
        return value as bool;
      });
    }
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onTicketFetched(TicketResponse rmDetailResponse) {
    openTickets.clear();
    closedTickets.clear();
    rmDetailResponse.openCasesList.forEach((element) {
      openTickets.add(element);
    });

    rmDetailResponse.closedCasesList.forEach((element) {
      closedTickets.add(element);
    });
    setState(() {});
  }

  @override
  void onTicketCreated(CreateTicketResponse rmDetailResponse) {
    Navigator.pop(context); // close pop up
    Utility.showSuccessToastB(context, "Ticket Created");
    _presenter.getTicketsWithoutLoader(context);
    clearTicketDesc();
    setState(() {});
  }

  void clearTicketDesc() {
    _textEditingController.clear();
  }

  @override
  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    category.clear();
    if (rmDetailResponse.values.isNotEmpty) category.addAll(rmDetailResponse.values.split(","));
    if (category.isNotEmpty) {
      category.removeLast();

      String cat = category.first;
      _presenter.getTicketSubCategory(context, cat);
    }
    setState(() {});
  }

  @override
  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    subCategory.clear();
    if (rmDetailResponse.values.isNotEmpty) subCategory.addAll(rmDetailResponse.values.split(",").toList());
    if (subCategory.isNotEmpty) {
      subCategory.removeLast();
      val2 = subCategory.first;
      valueNotifier.value.clear();
      valueNotifier.value.addAll(subCategory);
      valueNotifier.notifyListeners();
    }
    setState(() {});
  }

  Future<bool> reopenTicketDialog(BuildContext context, String id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, alertDialogState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              Container(
                color: Colors.white,
                height: 300.0,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Reopen", style: textStyle14px500w),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(color: AppColors.colorSecondary.withOpacity(0.5))),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: textStyle14px500w,
                        decoration: new InputDecoration.collapsed(hintText: "Add reason here ..."),
                        onChanged: (v) {
                          _reopenTicketRequest.reason = v;
                        },
                      ),
                    ),
                    verticalSpace(10.0),
                    HrmInputFieldDummy(
                      // textController: dobTextController,
                      headingText: "Attach File",
                      text: _reopenTicketRequest.name == null ? "Add img, pdf or xls" : _reopenTicketRequest.name,
                    ).onClick(() async {
                      try {
                        List<String> fileAndName = await Utility.pickFile(context);
                        _reopenTicketRequest.attachFile = fileAndName[0].isEmpty ? null : fileAndName[0];
                        _reopenTicketRequest.name = fileAndName[1].isEmpty ? null : fileAndName[1];

                        // Split the file name by '.' to separate the name and extension
                        List<String> parts = _reopenTicketRequest.name.split('.');
                        _reopenTicketRequest.fileType = parts.last;
                      } catch (e) {
                        _reopenTicketRequest.attachFile = null;
                        _reopenTicketRequest.name = null;
                      }
                      alertDialogState(() {});
                    }),
                    verticalSpace(10.0),
                    Spacer(),
                    PmlButton(
                      text: "Reopen",
                      onTap: () async {
                        if (_reopenTicketRequest?.reason?.isEmpty ?? true) {
                          onError("Please enter reason");
                          return;
                        }

                        _reopenTicketRequest.caseId = id;
                        _presenter.reopenTicket(context, _reopenTicketRequest);
                        Navigator.pop(context);

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndC`onditionScreen()));
                        // Navigator.pushNamed(context, Screens.kHomeBase);
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        });
      },
    ).then((value) {
      _reopenTicketRequest = ReopenTicketRequest();
      return value as bool;
    });
  }

  @override
  void onTicketReopened(ReopenResponse rmDetailResponse) {
    _presenter.getTicketsWithoutLoader(context);
  }

  @override
  void onTicketPicklistFetched(TicketPicklistResponse rmDetailResponse) {}

  @override
  void caseSubTypeResponse(CaseSubtypeResponse rmDetailResponse) {}

  @override
  void onFeedbackSubmitted() {
    isShowing = false;
    Navigator.pop(context); // close popup;
    _presenter.getTicketsWithoutLoader(context);
    Utility.showSuccessToastB(context, "Feedback submitted");
  }
}

class IconItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  IconItem({@required this.icon, @required this.isSelected, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        child: Icon(
          icon,
          size: 24.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
