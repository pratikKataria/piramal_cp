import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/booking_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/walkin_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/pml_outline_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin implements HomeView {
  TabController _tabController;
  bool filterIsOpen = true;
  String currentSelectedTab = "Walk in";
  HomePresenter _homePresenter;

  List bookingListWidgets = [];
  List walkInListWidgets = [];

  String events = "Currently no events available";

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _homePresenter = HomePresenter(this);
    _homePresenter.getWalkInList();
    _homePresenter.getEventList(context);
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
          if (walkInListWidgets.isNotEmpty)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    children: walkInListWidgets.map<Widget>((e) => WalkInCardWidget(e, _homePresenter)).toList(),
                  ),
                  ListView(
                    children: bookingListWidgets.map<Widget>((e) => BookingCardWidget(e, _homePresenter)).toList(),
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
          Row(
            children: [
              PmlOutlineButton(
                text: "Aranya",
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 25.0,
                textStyle: textStyle12px500w,
              ),
              horizontalSpace(10.0),
              PmlOutlineButton(
                text: "Mahalaximi",
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 25.0,
                textStyle: textStyle12px500w,
              ),
              horizontalSpace(10.0),
              PmlOutlineButton(
                text: "Revanta",
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 25.0,
                textStyle: textStyle12px500w,
              ),
            ],
          ),
          verticalSpace(14.0),
          Text("Lead Status", style: textStyleRegular16px400w),
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
        Tab(
          child: currentSelectedTab == "Walk in"
              ? PmlOutlineButton(
                  text: "Walk in",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "Walk in";
                    _tabController.index = 0;
                    setState(() {});
                  },
                )
              : PmlButton(
                  text: "Walk in",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "Walk in";
                    _tabController.index = 0;
                    setState(() {});
                  },
                ),
        ),
        Tab(
          child: currentSelectedTab == "Booking"
              ? PmlOutlineButton(
                  text: "Booking",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "Booking";
                    _tabController.index = 1;
                    setState(() {});
                  },
                )
              : PmlButton(
                  text: "Booking",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "Booking";
                    _tabController.index = 1;
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
            blankSpace: 20.0,
            velocity: 100.0,
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

  int totalCustomerCount() {
    return bookingListWidgets.length + walkInListWidgets.length;
  }

  @override
  void onBookingListFetched(List<BookingResponse> brList) {
    bookingListWidgets.clear();
    bookingListWidgets.addAll(brList);
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onWalkInListFetched(List<BookingResponse> wList) {
    walkInListWidgets.clear();
    walkInListWidgets.addAll(wList);
    _homePresenter.getBookingList(context);
    setState(() {});
  }

  @override
  Future<void> onTokenRegenerated(TokenResponse tokenResponse) async {
    //Save token
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.tokenResponse = tokenResponse;
    AuthUser.getInstance().updateUser(currentUser);

    //sent request again
    _homePresenter.getWalkInList();
  }

  @override
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse) {
    // Navigator.pop(context);
    Utility.showSuccessToastB(context, "Visit Scheduled");
  }

  @override
  void onEventFetched(List<CpEventResponse> brList) {
    events = "";
    brList.forEach((element) {
      events = "$events ${element.eventName}      \u2022";
    });
  }
}
