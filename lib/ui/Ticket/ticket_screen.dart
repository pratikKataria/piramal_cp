import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/case_subtype_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/reopen_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_picklist_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/extension.dart';
import 'package:piramal_channel_partner/widgets/krc_list_v2.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

import 'model/ticket_category_response.dart';
import 'model/ticket_response.dart';
import 'ticket_presenter.dart';
import 'ticket_view.dart';

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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _presenter = TicketPresenter(this);

    _presenter.getTickets(context);

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
          verticalSpace(20.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                KRCListViewV2(
                  children: [
                    ...openTickets
                        .map((e) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              color: AppColors.screenBackgroundColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  verticalSpace(12.0),
                                  Text("${e.detailCaseRemarks == null ? "" : e.detailCaseRemarks} (#${e.caseNumber})", style: textStyle12px500w),
                                  verticalSpace(15.0),
                                  if (e.type != null) Text("Type", style: textStyle12px500w),
                                  if (e.type != null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...e.type
                                              .split(";")
                                              .map((e) => Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                                  margin: EdgeInsets.only(right: 10.0),
                                                  color: AppColors.textColorSubText,
                                                  child: Text("$e".notNull, style: textStyleWhite12px500w)))
                                              .toList(),
                                        ],
                                      ),
                                    ),
                                  verticalSpace(15.0),
                                  if (e.subType != null) Text("Sub Type", style: textStyle12px500w),
                                  if (e.subType != null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...e.subType
                                              .split(";")
                                              .map((e) => Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                                  margin: EdgeInsets.only(right: 10.0),
                                                  color: AppColors.textColorSubText,
                                                  child: Text("$e".notNull, style: textStyleWhite12px500w)))
                                              .toList(),
                                        ],
                                      ),
                                    ),
                                  verticalSpace(15.0),
                                  Wrap(
                                    children: [
                                      Text("Created On", style: textStyleBlack10px500w),
                                      Text(" ${e.createdDate}".notNull, style: textStylePrimary10px500w),
                                      // Text(" At", style: textStyleBlack10px500w),
                                      // Text(" ${e.timeData}".notNull, style: textStylePrimary10px500w),
                                      Text(" | OPEN", style: textStylePrimary10px500w),
                                    ],
                                  ),
                                  verticalSpace(10.0),
                                  line(),
                                  verticalSpace(10.0),
                                  Center(child: Text("Your ticket will be updated soon", style: textStyleSubText10px500w)),
                                  verticalSpace(12.0),
                                ],
                              ),
                            ))
                        .toList(),
                  ] /*openTickets.map<Widget>((e) => cardViewTicket(e)).toList()*/,
                ),
                KRCListViewV2(
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
      indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
          color: Colors.red
      ),
      indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
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
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          // image: DecorationImage(image: AssetImage(Assets.imagesIcTicket), fit: BoxFit.fill),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("${e.subType} (#${e.caseNumber})", style: textStyle12px500w),
          Text("${e.detailCaseRemarks}".notNull, style: textStylePrimary12px500w),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              color: AppColors.textColorSubText,
              child: Text("${e.category}".notNull, style: textStyleWhite12px500w)),
          Center(child: Text("Your ticket will be updated soon", style: textStyleSubText10px500w)),

          // Container(
          //   padding: EdgeInsets.all(8),
          //   color: AppColors.white.withOpacity(0.06),
          //   child: Text(e.status, style: textStyleWhite14px600w),
          // ),
          line(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Created On", style: textStyleBlack10px500w),
                      Text(" ${e.createdDate}".notNull, style: textStylePrimary10px500w),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("At", style: textStyleBlack10px500w),
                  //     Text(" ${e.tim}".notNull, style: textStylePrimary10px500w),
                  //   ],
                  // ),
                ],
              ),
              horizontalSpace(20.0),
              Image.asset(Assets.imagesIcReopen, height: 50).onClick(() {
                FocusScope.of(context).unfocus();
                reopenTicketDialog(context, e.caseId);
              })
            ],
          ),
          // Container(
          //   padding: EdgeInsets.all(8),
          //   color: AppColors.white.withOpacity(0.06),
          //   child: Text(e.status, style: textStyleWhite14px600w),
          // ),
        ],
      ),
    );
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
        String reason = "";
        return StatefulBuilder(builder: (context, alertDialogState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              Container(
                color: Colors.white,
                height: 235.0,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Reopen", style: textStyle14px500w),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(color: AppColors.textColorSubText.withOpacity(0.5))),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: textStyle14px500w,
                        decoration: new InputDecoration.collapsed(hintText: "Add reason here ..."),
                        onChanged: (v) {
                          reason = v;
                        },
                      ),
                    ),
                    verticalSpace(10.0),
                    Spacer(),
                    PmlButton(
                      text: "Reopen",
                      onTap: () {
                        if (reason.isNotEmpty) {
                          _presenter.reopenTicket(context, id, reason);
                        } else {
                          onError("Please enter reason");
                        }
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
    ).then((value) => value as bool);
  }

  @override
  void onTicketReopened(ReopenResponse rmDetailResponse) {
    _presenter.getTicketsWithoutLoader(context);
    Navigator.pop(context);
  }

  @override
  void onTicketPicklistFetched(TicketPicklistResponse rmDetailResponse) {}

  @override
  void caseSubTypeResponse(CaseSubtypeResponse rmDetailResponse) {}
}
