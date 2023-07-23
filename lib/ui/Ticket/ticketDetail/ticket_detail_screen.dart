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
  final String caseID;

  TicketDetailScreen(this.caseID, {Key key}) : super(key: key);

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> implements TicketDetailView {
  TicketPresenter _presenter;

  TicketDetailResponse rmDetailResponse;

  @override
  void initState() {
    _presenter = TicketPresenter(this);
    // _homePresenter.getWalkInList(context);
    _presenter.getCaseDetails(context, widget.caseID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshListView(
      onRefresh: () {
        _presenter.getCaseDetails(context, widget.caseID);
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            key: bookedCustomerTopProfile,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10.0),
              //customer pic with name and time
              if (rmDetailResponse != null)
                Text("${rmDetailResponse.description == null ? "" : rmDetailResponse.description} (#${rmDetailResponse.caseNumber})", style: textStyleRegular18pxW500),

              //chip layout
              // verticalSpace(12.0),
              // Container(
              //   height: 30,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       ...[
              //         Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(6),
              //             color: AppColors.chipColor,
              //           ),
              //           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              //           child: Text("Revisit", style: textStyle14px500w),
              //         ),
              //         horizontalSpace(10.0),
              //       ],
              //       Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(6),
              //           color: AppColors.chipColor,
              //         ),
              //         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              //         child: Text("${widget?.response?.projectFinalized ?? "NA"}", style: textStyle14px500w),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),

        //Comment layout
        verticalSpace(30.0),
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
                  Text("On  ${rmDetailResponse?.createdDate}", style: textStyleSubText14px500w),
                ],
              ),
              verticalSpace(25.0),
              downloadButtonWidget(),
              verticalSpace(25.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.info, size: 14.0, color: AppColors.colorSecondary),
                  horizontalSpace(12.0),
                  Text("Sign, stamp & submit at site", style: textStyle14px500w),
                ],
              ),
              verticalSpace(20.0),
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

        // verticalSpace(20.0),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //   child: Column(
        //     key: bookedCustomerProgressStatus,
        //     children: [
        //       ...timelineViewBuilder(),
        //     ],
        //   ),
        // ),

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
  void onTicketDetailsFetched(TicketDetailResponse rmDetailResponse) {
    this.rmDetailResponse = rmDetailResponse;
    setState(() {});
  }
}
