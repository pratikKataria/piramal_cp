import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/extension/extention%20function.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/case_subtype_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/create_ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/reopen_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_category_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_detail_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_picklist_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/ticketDetail/ticket_detail_view.dart';
import 'package:piramal_channel_partner/ui/Ticket/ticket_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/tour_keys_bottom_navigation.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/generate_invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_number_request.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_presenter.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/download_button.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketDetailScreen extends StatefulWidget {
  final OpenCasesList arguments;

  TicketDetailScreen(this.arguments, {Key key}) : super(key: key);

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> implements TicketDetailView {
  TicketPresenter _presenter;

  TicketDetailResponse rmDetailResponse;
  List<TicketDetailResponse> responseList = [];

  @override
  void initState() {
    _presenter = TicketPresenter(this);
    // _homePresenter.getWalkInList(context);
    _presenter.getCaseDetails(context, widget.arguments.caseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (responseList.isNotEmpty) {
      rmDetailResponse = responseList.first;
    }

    return RefreshListView(
      onRefresh: () {
        _presenter.getCaseDetails(context, widget.arguments.caseId);
      },
      children: [
        if (rmDetailResponse != null) ...[
          Container(
            width: Utility.screenWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalSpace(12.0),
                Text("Case No: ${widget.arguments.caseNumber}", style: textStyle14px500w),
                verticalSpace(4.0),
                Text("Description: ${widget.arguments.detailCaseRemarks == null ? "" : widget.arguments.detailCaseRemarks}", style: textStyle14px500w),
                verticalSpace(4.0),
                Wrap(
                  children: [
                    Text("Created On", style: textStyle14px500w),
                    Text(" ${widget.arguments.createdDate}".notNull, style: textStylePrimary14px500w),
                    // Text(" At", style: textStyleBlack10px500w),
                    // Text(" ${e.timeData}".notNull, style: textStylePrimary10px500w),
                    Text(" | ${widget.arguments.status}", style: textStylePrimary14px500w),
                  ],
                ),
                verticalSpace(10.0),
                if (widget.arguments.type != null) ...[
                  Text("Type", style: textStyle14px500w),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...widget.arguments.type
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
                if (widget.arguments.subType != null) ...[
                  Text("Sub Type", style: textStyle14px500w),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...widget.arguments.subType
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
              ],
            ),
          ),
        ],

        //Comment layout
        verticalSpace(10.0),
        line(),
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              verticalSpace(20.0),
              Row(
                key: bookedCustomerDetails,
                children: [
                  Text("Attachment", style: textStyle20px500w),
                  horizontalSpace(12.0),
                  Text("On  ${rmDetailResponse?.createdDate ?? ""}", style: textStyleSubText14px500w),
                ],
              ),
              verticalSpace(25.0),
              downloadButtonWidget(),
              // verticalSpace(25.0),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Icon(Icons.info, size: 14.0, color: AppColors.colorSecondary),
              //     horizontalSpace(12.0),
              //     Text("Sign, stamp & submit at site", style: textStyle14px500w),
              //   ],
              // ),
              // verticalSpace(20.0),
            ],
          ),
        ),
        line(),

        verticalSpace(20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Status", style: textStyle20px500w),
              horizontalSpace(12.0),
              // Text("On March 21th, 2021", style: textStyleSubText14px500w),
            ],
          ),
        ),

        verticalSpace(20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            key: bookedCustomerProgressStatus,
            children: [
              ...timelineViewBuilder(),
            ],
          ),
        ),

        verticalSpace(30.0),
        line(),
      ],
    );
  }

  Container downloadButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      margin: EdgeInsets.only(bottom: 25.0),
      color: AppColors.screenBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Download", style: textStyleRegular16px500px),
          PmlButton(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(8.0),
            onTap: () {
              Utility.launchUrlX(context, "${rmDetailResponse?.caseFileLink}");
            },
            child: Image.asset(Images.kIconDownload),
          )
        ],
      ),
    );
  }

  List<Column> timelineViewBuilder() {
    List<Column> colList = [];

    int currentStatusIndex = 99;
    responseList?.forEach((element) {
      if (element.currentStatus == element.status) currentStatusIndex = element.position;
      print("elemen positon ${element.position} current status position $currentStatusIndex");
      colList.insert(
        element.position,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (element.position != 0)
              Container(
                width: 2.0,
                height: 50.0,
                margin: EdgeInsets.only(left: 3.4),
                decoration: BoxDecoration(
                  color: element.position <= currentStatusIndex ? getColorFromStatus(element.status) : AppColors.textColorHeather,
                ),
              ),
            Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: element.position <= currentStatusIndex ? getColorFromStatus(element.status) : AppColors.textColorHeather,
                  ),
                ),
                horizontalSpace(10.0),
                Text(
                  element?.status ?? "",
                  style: element.position <= currentStatusIndex ? getTextStyleFromStatus(element.status) : textStyleSubText10px500w,
                )
              ],
            ),
          ],
        ),
      );
    });

    return colList;
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void caseSubTypeResponse(CaseSubtypeResponse rmDetailResponse) {}

  @override
  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse) {}

  @override
  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse) {}

  @override
  void onTicketCreated(CreateTicketResponse rmDetailResponse) {}

  @override
  void onTicketFetched(TicketResponse rmDetailResponse) {}

  @override
  void onTicketPicklistFetched(TicketPicklistResponse rmDetailResponse) {}

  @override
  void onTicketReopened(ReopenResponse rmDetailResponse) {}

  @override
  void onTicketDetailsFetched(List<TicketDetailResponse> rmDetailResponse) {
    this.responseList.addAll(rmDetailResponse);
    setState(() {});
  }

  getColorFromStatus(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return AppColors.warm;
        break;
      case "in progress":
        return AppColors.amber;
        break;
      case "closed":
        return AppColors.green;
        break;
    }
  }

  getTextStyleFromStatus(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return textStyleSubText10px500w.withColor(AppColors.warm);
        break;
      case "in progress":
        return textStyleSubText10px500w.withColor(AppColors.amber);
        break;
      case "closed":
        return textStyleSubText10px500w.withColor(AppColors.green);
        break;
    }
  }

  @override
  void onFeedbackSubmitted() {}
}
