import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/booking_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_screen.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/account_status_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/cp_banner_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/current_promotion_blocker_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/dueInvoice/due_invoice_view.dart';
import 'package:piramal_channel_partner/ui/myAssit/projectList/project_screen_tour_keys.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'due_invoice_presenter.dart';
import 'model/invoices_response.dart';

class DueInvoiceScreen extends StatefulWidget {
  const DueInvoiceScreen({Key key}) : super(key: key);

  @override
  _DueInvoiceScreenState createState() => _DueInvoiceScreenState();
}

class _DueInvoiceScreenState extends State<DueInvoiceScreen>  with SingleTickerProviderStateMixin  implements DueInvoiceView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  TabController _tabController;

  DueInvoicePresenter projectPresenter;
  List<ProjectListResponse> listOfProjects = [];
  List<PaidInvoicesList> paidInvoicesList = [];
  List<DueInvoicesList> dueInvoicesList = [];

  TutorialCoachMark globalTutorialCoachMark;

  @override
  void initState() {
    super.initState();
    projectPresenter = DueInvoicePresenter(this);
    projectPresenter.getInvoices(context);

    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(10.0),
             buildTabs(),
            verticalSpace(8.0),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  if (paidInvoicesList.isEmpty)
                    RefreshListView(
                      onRefresh: () {
                        // _presenter.getTickets(context);
                      },
                      children: [
                        Container(height: Utility.screenHeight(context) * 0.3),
                        Center(child: Text("No Invoices Present")),
                      ],
                    ),
                  if (paidInvoicesList.isNotEmpty)
                    RefreshListView(
                      onRefresh: () {
                        // _presenter.getTickets(context);
                      },
                      children: [
                        ...paidInvoicesList.map((e) => BookingCardWidget(BookingResponse.fromJson(e.toJson()), projectPresenter)).toList(),
                      ] /*openTickets.map<Widget>((e) => cardViewTicket(e)).toList()*/,
                    ),
                  if (dueInvoicesList.isEmpty)
                    RefreshListView(
                      onRefresh: () {
                        // _presenter.getTickets(context);
                      },
                      children: [
                        Container(height: Utility.screenHeight(context) * 0.3),
                        Center(child: Text("No Invoices Present", style: textStyle14px500w)),
                      ],
                    ),
                  if (dueInvoicesList.isNotEmpty)
                    RefreshListView(
                      onRefresh: () {
                        // _presenter.getTickets(context);
                      },
                      children: [
                        ...dueInvoicesList.map((e) => BookingCardWidget(BookingResponse.fromJson(e.toJson()), projectPresenter)).toList(),
                        // ...dueInvoicesList.map((e) => cardViewTicketClosed(e)).toList(),
                      ] /*closedTickets.map<Widget>((e) => cardViewTicket(e)).toList()*/,
                    ),
                ],
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
          Utility.setTourCompleted(Screens.kSettingsScreen);return true;
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

  List<BookingResponse> bookingList = [];

  @override
  void onBookingListFetched(List<BookingResponse> brList) {
    bookingList.clear();
    bookingList.addAll(brList);


  /*  if (bookingList.isNotEmpty) {
      bookingList.first.mapOfKeys.addAll({
        "homeBookingTitle": homeBookingTitle,
        "homeBookingStatus": homeBookingStatus,
        "homeBookingCall": homeBookingCall,
        "homeBookingWhatsapp": homeBookingWhatsapp,
        "homeBookingUnit": homeBookingUnit,
      });
    }*/

    setState(() {});
  }

  @override
  void noEventPresent() {
    // TODO: implement noEventPresent
  }

  @override
  void onAccountStatusChecked(AccountStatusResponse projectUnitResponse) {
    // TODO: implement onAccountStatusChecked
  }

  @override
  void onCurrentPromotionPageBlockerDataFetched(List<PageBlockerList> pageBlockersImagesList) {
    // TODO: implement onCurrentPromotionPageBlockerDataFetched
  }

  @override
  void onEventFetched(List<BannerDataList> bannerDataList) {
    // TODO: implement onEventFetched
  }

  @override
  void onPaymentAcknowledged() {
    // TODO: implement onPaymentAcknowledged
  }

  @override
  void onProjectUnitResponseFetched(ProjectUnitResponse projectUnitResponse) {
    showDetailDialog(context, projectUnitResponse);
  }

  void showDetailDialog(BuildContext context, ProjectUnitResponse projectUnitResponse) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Unit details", style: textStyle14px500w),
                buildDialogRow("Unit Number", "${projectUnitResponse?.apartmentFinalized}"),
                buildDialogRow("Tower", "${projectUnitResponse?.towerFinalized}"),
                buildDialogRow("Carpet Area", "${projectUnitResponse?.carpetarea}"),
                buildDialogRow("Agreement Value", "${projectUnitResponse?.totalAgreementValue}"),
                verticalSpace(10.0),
                /*Text("Payment details", style: textStyle14px500w),
                buildDialogRow("Payment to Broker by BN Status", "${projectUnitResponse?.paymentToBrokerByBNStatus ?? ""}"),
                buildDialogRow("Payment date", "${projectUnitResponse?.paymentDate ?? ""}"),
                buildDialogRow("Amount Paid", "${projectUnitResponse?.amountPaid ?? ""}"),
                buildDialogRow("Payment detail", "${projectUnitResponse?.paymentDetail ?? ""}"),
                verticalSpace(10.0),
                if (projectUnitResponse?.paymentByBN ?? false)
                  PmlButton(
                    height: 30.0,
                    text: !(projectUnitResponse?.paymentConfirmationByCP ?? false) ? "Acknowledge Payment" : "Payment Acknowledged",
                    color: !(projectUnitResponse?.paymentConfirmationByCP ?? false) ? AppColors.colorPrimary : AppColors.colorPrimary.withOpacity(0.5),
                    onTap: () async {
                      if (!(projectUnitResponse?.paymentConfirmationByCP ?? false)) {
                        _homePresenter.acknowledgePayment(context, projectUnitResponse.sfdcid, projectUnitResponse.brokerageRecordId);
                      }
                    },
                  )*/
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: PmlButton(
              width: 30,
              height: 30,
              color: AppColors.colorPrimary,
              child: Icon(Icons.close, color: AppColors.white, size: 16.0),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Column buildDialogRow(String s, String m) {
    return Column(
      children: [
        verticalSpace(16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$s", style: textStyleSubText12px400w),
            Text("$m", style: textStyle12px500w),
          ],
        ),
        verticalSpace(16.0),
        line()
      ],
    );
  }



  @override
  void onInvoicesListFetched(InvoicesResponse invoiceList) {
    paidInvoicesList.clear();
    dueInvoicesList.clear();
    invoiceList.paidInvoicesList.forEach((element) {
      paidInvoicesList.add(element);
    });

    invoiceList.dueInvoicesList.forEach((element) {
      dueInvoicesList.add(element);
    });
    setState(() {});
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
          text: "Paid",
        ),
        Tab(
          text: "Due",
        ),
      ],
    );
  }


  @override
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse) {
    // TODO: implement onSiteVisitScheduled
  }

  @override
  void onTaggingDone() {
    // TODO: implement onTaggingDone
  }

  @override
  void onTokenRegenerated(TokenResponse tokenResponse) {
    // TODO: implement onTokenRegenerated
  }

  @override
  void onWalkInListFetched(List<BookingResponse> brList) {
    // TODO: implement onWalkInListFetched
  }

}
