import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/model/today_sv_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/today_sv_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/today_sv_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/widgets/sv_booking_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/widgets/sv_walkin_card_widget.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/pml_outline_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';

class TodayFollowUpScreen extends StatefulWidget {
  const TodayFollowUpScreen({Key key}) : super(key: key);

  @override
  _TodayFollowUpScreenState createState() => _TodayFollowUpScreenState();
}

class _TodayFollowUpScreenState extends State<TodayFollowUpScreen> with SingleTickerProviderStateMixin implements TodayView {
  TabController _tabController;
  bool filterIsOpen = true;
  String currentSelectedTab = "Walk in";
  TodaySVPresenter _homePresenter;

  List<BookingResponse> bookingListWidgets = [];
  List<BookingResponse> walkInListWidgets = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _homePresenter = TodaySVPresenter(this);
    _homePresenter.getSvList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                RefreshListView(
                  onRefresh: () {
                    _homePresenter.getSvList(context);
                  },
                  children: walkInListWidgets.map<Widget>((e) => SvWalkInCardWidget(e, _homePresenter)).toList(),
                ),
                RefreshListView(
                  onRefresh: () {
                    _homePresenter.getSvList(context);
                  },
                  children: bookingListWidgets.map<Widget>((e) => SvBookingCardWidget(e, _homePresenter)).toList(),
                ),
              ],
            ),
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
          child: currentSelectedTab == "Walk in"
              ? PmlButton(
                  text: "Walk in",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "Walk in";
                    _tabController.index = 0;
                    setState(() {});
                  },
                )
              : PmlOutlineButton(
                  text: "Walk in",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "Walk in";
                    _tabController.index = 0;
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
                    _tabController.index = 1;
                    setState(() {});
                  },
                )
              : PmlOutlineButton(
                  text: "Booking",
                  height: 28.0,
                  textStyle: textStyle12px500w,
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
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Piramal Aranya  •  Piramal Mahalaxmi Tower 3",
              style: textStyleWhite12px600w,
              maxLines: 1,
            ),
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
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onSvListFetched(List<TodaySvResponse> brList) {
    bookingListWidgets.clear();
    walkInListWidgets.clear();
    brList.forEach((element) {
      if (!element.returnCode) {
        onError(element.message);
        return;
      }

      BookingResponse bookingResponse = BookingResponse()
        ..stageName = element.stageName
        ..name = element.name
        ..newRating = element.rating
        ..revisit = element.revisit
        ..createdDays = element.validDays
        ..mobilenumber = element.mobilenumber
        ..sfdcid = element.opportunityID
        ..apartmentFinalized = element.apartmentFinalized
        ..projectFinalized = element.projectFinalized
        ..taggingStatus = element.completeTaggingStatus;
      if (element.stageName == "WalkIn") {
        walkInListWidgets.add(bookingResponse);
      } else {
        bookingListWidgets.add(bookingResponse);
      }
    });

    setState(() {});
  }

  @override
  void onTaggingDone() {
    Utility.showSuccessToastB(context, "Tagging completed");
    _homePresenter.getSvList(context);
  }
}
