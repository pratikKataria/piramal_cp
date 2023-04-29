import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/booking_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/walkin_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/account_status_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/ui/lead/lead_presenter.dart';
import 'package:piramal_channel_partner/ui/lead/lead_view.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/pml_outline_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:provider/provider.dart';

String currentSelectedTab = "Lead";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin implements HomeView, LeadView {
  TabController _tabController;
  HomePresenter _homePresenter;
  LeadPresenter _leadPresenter;

  List<BookingResponse> bookingList = [];
  List<BookingResponse> walkInList = [];
  List<AllLeadResponse> listOfLeads = [];
  List<String> projectList = [];

  String events = "Currently no events available";
  String filterValue;
  bool dueInvoice = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _homePresenter = HomePresenter(this);
    _leadPresenter = LeadPresenter(this);

    _leadPresenter.getLeadListS(context);

    _homePresenter.getAccountStatus(context);
    _homePresenter.getEventList(context);
    _homePresenter.postDeviceToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BaseProvider>(context, listen: false);
    if (!provider.showAppbarAndBottomNavigation) provider.showToolTip();

    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eventRibbon(),
          Consumer<BaseProvider>(
            builder: (_, provider, __) {
              return Column(
                children: [
                  if (provider.filterIsOpen) ...[
                    buildFilter(),
                    verticalSpace(23.5),
                    Container(height: 2, color: AppColors.lineColor),
                  ]
                ],
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10.0),
                Text("Customers (${totalCustomerCount()})", style: textStyle20px500w),
                verticalSpace(6.0),
                buildTabs(),
                verticalSpace(18.0),
              ],
            ),
          ),
          // if (walkInList.isNotEmpty)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                RefreshListView(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  onRefresh: () {
                    _leadPresenter.getLeadList(context);
                  },
                  children:
                      listOfLeads.where((element) => filterValue == null || filterValue == element.projectInterested).map<Widget>((element) => cardViewLead(element)).toList(),
                ),
                RefreshListView(
                  children: getWalkInListByFilterValue(),
                  onRefresh: () {
                    _homePresenter.getAccountStatusS(context);
                    // _homePresenter.getWalkInListV2(context);
                    _homePresenter.getEventList(context);
                  },
                ),
                RefreshListView(
                  children: getBookingListByFilterValue(),
                  onRefresh: () {
                    // _homePresenter.getWalkInListV2(context);
                    _homePresenter.getAccountStatusS(context);
                    _homePresenter.getEventList(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildFilter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project", style: textStyleRegular16px400w),
          verticalSpace(8.0),
          Container(
            height: 25.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: projectList
                  .map<Widget>((e) => PmlOutlineButton(
                        onTap: () {
                          filterValue = e == filterValue ? null : e;
                          setState(() {});
                        },
                        text: "${e}",
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        margin: EdgeInsets.only(right: 10.0),
                        height: 25.0,
                        fillColor: filterValue == e ? AppColors.colorSecondary : AppColors.screenBackgroundColor,
                        textStyle: filterValue == e ? textStyleWhite12px500w : textStyle12px500w,
                      ))
                  .toList(),
            ),
          ),
          if (_tabController.index == 2) verticalSpace(20.0),
          if (_tabController.index == 2)
            Row(
              children: [
                PmlOutlineButton(
                  onTap: () {
                    dueInvoice = !dueInvoice;
                    setState(() {});
                  },
                  text: "Due Invoice",
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(right: 10.0),
                  height: 25.0,
                  fillColor: dueInvoice ? AppColors.colorSecondary : AppColors.screenBackgroundColor,
                  textStyle: dueInvoice ? textStyleWhite12px500w : textStyle12px500w,
                ),
              ],
            ),
        ],
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelStyle: textStyleDark14px500w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelColor: AppColors.textColorGreen,
      onTap: (int index) {
        setState(() {});
      },
      tabs: [
        Tab(
          child: currentSelectedTab == "Lead"
              ? PmlButton(
                  text: "Lead",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "Lead";
                    _tabController.index = 0;
                    setState(() {});
                  },
                )
              : PmlOutlineButton(
                  text: "Lead",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "Lead";
                    _tabController.index = 0;
                    setState(() {});
                  },
                ),
        ),
        Tab(
          child: currentSelectedTab == "Walk in"
              ? PmlButton(
                  text: "Walk in",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "Walk in";
                    _tabController.index = 1;
                    setState(() {});
                  },
                )
              : PmlOutlineButton(
                  text: "Walk in",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "Walk in";
                    _tabController.index = 1;
                    setState(() {});
                  },
                ),
        ),
        Tab(
          child: currentSelectedTab == "Booking"
              ? PmlButton(
                  text: "Booking",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "Booking";
                    _tabController.index = 2;
                    setState(() {});
                  },
                )
              : PmlOutlineButton(
                  text: "Booking",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "Booking";
                    _tabController.index = 2;
                    setState(() {});
                  },
                ),
        ),
      ],
    );
  }

  Stack eventRibbon() {
    return Stack(
      children: [
        Container(
          height: 45.0,
          padding: EdgeInsets.only(bottom: 6.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppColors.colorPrimary),
          child: Marquee(
            text: '\n $events',
            style: textStyleWhite12px600w,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 8.0,
            velocity: 50.0,
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 200),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Positioned(
          top: 35.0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              color: AppColors.screenBackgroundColor,
            ),
          ),
        ),
      ],
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
                color: AppColors.screenBackgroundColor,
                child: Icon(Icons.edit, size: 16),
                onTap: () async {
                  BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
                  baseProvider.setBottomNavScreen(Screens.kEditLeadScreen);
                  var created = await Navigator.pushNamed(context, Screens.kEditLeadScreen, arguments: leadData);
                  if (created is bool && created) _leadPresenter.getLeadListS(context);
                },
              ),
              horizontalSpace(10.0),
              PmlButton(
                height: 32.0,
                width: 32.0,
                color: AppColors.colorPrimaryLight,
                child: Icon(Icons.delete, color: AppColors.colorPrimary, size: 16),
                onTap: () => _leadPresenter.deleteLead(context, leadData),
              ),
            ],
          ),
          line(),
          Wrap(
            runSpacing: 10.0,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.chipColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text("${leadData.projectInterested}", style: textStyle12px500w),
              ),
              horizontalSpace(10.0),
              if (leadData.cpLeadStatus != null && leadData.cpLeadStatus.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.chipColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("${leadData.cpLeadStatus}", style: textStyle14px500w),
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
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onBookingListFetched(List<BookingResponse> brList) {
    bookingList.clear();
    bookingList.addAll(brList);
    //filter project form the response and add it to the project list
    bookingList.forEach((booking) => addProjectListValue(booking.projectFinalized));
    setState(() {});
  }

  @override
  void onWalkInListFetched(List<BookingResponse> wList) {
    walkInList.clear();
    walkInList.addAll(wList);
    //filter project form the response and add it to the project list
    walkInList.forEach((booking) => addProjectListValue(booking.projectInterested));
    setState(() {});
  }

  @override
  void onTokenRegenerated(TokenResponse tokenResponse) async {
    //Save token
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.tokenResponse = tokenResponse;
    AuthUser.getInstance().updateUser(currentUser);

    //sent request again
    _homePresenter.getWalkInListV2s(context);
    _homePresenter.getBookingList(context);
    _leadPresenter.getLeadListS(context);
  }

  @override
  Future<void> onSiteVisitScheduled(ScheduleVisitResponse visitResponse) async {
    // Navigator.pop(context);
    Utility.showSuccessToastB(context, "FUP scheduled.");

    if (visitResponse.schDate != null) {
      String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
      DateTime dt = visitResponse.schDate;
      print("old time ${dt.hour} ${dt.minute} ${dt.second}");
      dt = dt.subtract(Duration(minutes: 5));
      print("new time ${dt.hour} ${dt.minute} ${dt.second}");

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'New Upcoming site-visit',
          body: 'You have site visit for ${visitResponse.opportunityName}',
        ),
        schedule: NotificationCalendar(
          year: dt.year,
          month: dt.month,
          hour: dt.hour,
          minute: dt.minute,
          second: dt.second,
          timeZone: localTimeZone,
          allowWhileIdle: true,
          repeats: false,
        ),
      );
    }
  }

  @override
  void onEventFetched(List<CpEventResponse> brList) {
    events = "";
    brList.forEach((element) => events = "$events${element.eventName}     \u2022    ");
    setState(() {});
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
                Text("Payment details", style: textStyle14px500w),
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
                  )
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

  int totalCustomerCount() {
    return bookingList.length + walkInList.length;
  }

  void addProjectListValue(String val) {
    if (val != null && projectList.contains(val) == false) {
      projectList.add(val);
    }
  }

  getWalkInListByFilterValue() {
    List<Widget> walkInWidgetList = [];

    walkInWidgetList = walkInList
        .where((element) => filterValue == null || filterValue == element.projectInterested) // filter out by project
        .map((element) => WalkInCardWidget(element, _homePresenter)) // convert to map then to widget
        .toList(); // provide list

    return walkInWidgetList;
  }

  List<Widget> getBookingListByFilterValue() {
    return bookingList
        .where((element) => (filterValue == null || filterValue == element.projectFinalized) && dueInvoice == element.dueInvoice) // filter out by project
        .map((element) => BookingCardWidget(element, _homePresenter)) // convert to map then to widget
        .toList(); // provide list

    return bookingList
        .where((element) {
          if (filterValue == null) {
            return true;
          } else if (filterValue == "projectFinalized") {
            return element.projectFinalized == true;
          } else if (filterValue == "dueInvoice") {
            return dueInvoice;
          }
          return false;
        })
        .map((element) => BookingCardWidget(element, _homePresenter))
        .toList();
  }

  @override
  void onTaggingDone() {
    Utility.showSuccessToastB(context, "Tagging completed");
    _homePresenter.getWalkInListV2s(context);
  }

  @override
  void onAccountStatusChecked(AccountStatusResponse accountStatusResponse) async {
    switch (accountStatusResponse.applicationStatus) {
      case Constants.ADMIN:
        await updateUserCreds(accountStatusResponse?.customerAccountID);
        _homePresenter.getWalkInList(context);
        _homePresenter.getBookingList(context);
        break;
      case Constants.GUEST_USER:
        break;
      case Constants.IN_PROGRESS:
        showApplicationInProcessDialog();
        break;
      case Constants.APPROVED:
        await updateUserCreds(accountStatusResponse?.customerAccountID);
        _homePresenter.getWalkInList(context);
        _homePresenter.getBookingList(context);
        break;
    }
  }

  void updateUserCreds(String uId) async {
    if (uId == null || uId.isEmpty) {
      return;
    }

    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.userCredentials..accountId = uId;
    await AuthUser.getInstance().updateUser(currentUser);
  }

  void showApplicationInProcessDialog() {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Application in Process", style: textStyle20px500w),
                verticalSpace(10.0),
                Text(
                  "We have received your details. Our team will get in touch with you shortly!\nThank you.",
                  style: textStyle12px500w,
                ),
                verticalSpace(10.0),
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

  void updateHome() {
    setState(() {});
    _homePresenter.getWalkInListV2s(context);
  }

  @override
  void onPaymentAcknowledged() {
    Utility.showSuccessToastB(context, "Payment Acknowledged");
    Navigator.pop(context);
  }

  @override
  void noEventPresent() {
    events = "Currently no events available";
    setState(() {});
  }

  @override
  void onAllLeadFetched(List<AllLeadResponse> brList) {
    listOfLeads.clear();
    listOfLeads.addAll(brList);

    // add projects to project list
    // projectList.clear();

    listOfLeads.forEach((lead) {
      bool isProjectAlreadyPresent = projectList.contains(lead.projectInterested);
      if (!isProjectAlreadyPresent) projectList.add(lead.projectInterested);
    });
    setState(() {});
  }

  @override
  void onLeadDeleted(AllLeadResponse response) {
    listOfLeads.remove(response);
    setState(() {});
  }
}

/*   Text("Lead Status", style: textStyleRegular16px400w),
          verticalSpace(8.0),
          Row(
            children: [
              PmlOutlineButton(
                text: "Hot",
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 25.0,
                textStyle: textStylePrimary12px500w,
              ),
              horizontalSpace(10.0),
              PmlOutlineButton(
                text: "Warm",
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 25.0,
                textStyle: textStylePrimary12px500w,
              ),
              horizontalSpace(10.0),
              PmlOutlineButton(
                text: "Cold",
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 25.0,
                textStyle: textStyleBlue12px500w,
              ),
            ],
          ),*/

// Tab(
//   child: currentSelectedTab == "All"
//       ? PmlOutlineButton(
//           text: "All",
//           height: 28.0,
//           textStyle: textStyle12px500w,
//           onTap: () {
//             currentSelectedTab = "All";
//             _tabController.index = 0;
//             setState(() {});
//           },
//         )
//       : PmlButton(
//           text: "All",
//           height: 28.0,
//           textStyle: textStyleWhite12px500w,
//           color: AppColors.colorSecondary,
//           onTap: () {
//             currentSelectedTab = "All";
//             _tabController.index = 0;
//             setState(() {});
//           },
//         ),
// ),
