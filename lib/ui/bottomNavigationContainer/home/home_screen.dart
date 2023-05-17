import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:piramal_channel_partner/extension/extention%20function.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/booking_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/homeWidgets/walkin_card_widget.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/account_status_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/cp_banner_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/tour_keys_bottom_navigation.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/lead/lead_presenter.dart';
import 'package:piramal_channel_partner/ui/lead/lead_view.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/cached_image_widget.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/pml_outline_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'home_tour_key.dart';
import 'model/current_promotion_blocker_response.dart';

String currentSelectedTab = "CP Lead";
bool currentPromoShowing = false;

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
  Set<String> listOfYears = {};
  List<String> projectList = [];

  List<BannerDataList> listOfBannerStrings = [BannerDataList(bannerName: "No event available")];
  String filterValue;
  String filterQuarter;
  String filterYear;
  String dueInvoiceChecked;
  bool dueInvoice = false;

  int fiscalYearStartMonth = 4; // Assuming fiscal year starts in April

  TutorialCoachMark walkinTutorialCoachMark;
  TutorialCoachMark bookingTutorialCoachMark;

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
      floatingActionButton: currentSelectedTab == "CP Lead"
          ? PmlButton(
              height: 45.0,
              width: 45.0,
              color: AppColors.black,
              child: Icon(Icons.add, size: 24, color: AppColors.screenBackgroundColor),
              onTap: () async {
                provider.setBottomNavScreen(Screens.kAddLeadScreen);
                var created = await Navigator.pushNamed(context, Screens.kAddLeadScreen);
                if (created is bool && created) _leadPresenter.getLeadListS(context);
              },
            )
          : null,
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
                  children: getLeadListByFilterValue(),
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
          if (listOfYears.isNotEmpty) ...[
            verticalSpace(8.0),
            Text("Years", style: textStyleRegular16px400w),
            verticalSpace(8.0),
            Container(
              height: 25.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: listOfYears
                    .map<Widget>(
                      (e) => PmlOutlineButton(
                        onTap: () {
                          filterYear = e == filterYear ? null : e;
                          if (filterYear == null) filterQuarter = null;
                          setState(() {});
                        },
                        text: "${e.formatYear}",
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        margin: EdgeInsets.only(right: 10.0),
                        height: 25.0,
                        fillColor: filterYear == e ? AppColors.colorSecondary : AppColors.screenBackgroundColor,
                        textStyle: filterYear == e ? textStyleWhite12px500w : textStyle12px500w,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          if (listOfYears.isNotEmpty && filterYear != null) ...[
            verticalSpace(8.0),
            Text("Quarter", style: textStyleRegular16px400w),
            verticalSpace(8.0),
            Container(
              height: 25.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: ["Q1", "Q2", "Q3", "Q4"]
                    .map<Widget>((e) => PmlOutlineButton(
                          onTap: () {
                            filterQuarter = e == filterQuarter ? null : e;
                            setState(() {});
                          },
                          text: "${e.formatDate}",
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(right: 10.0),
                          height: 25.0,
                          fillColor: filterQuarter == e ? AppColors.colorSecondary : AppColors.screenBackgroundColor,
                          textStyle: filterQuarter == e ? textStyleWhite12px500w : textStyle12px500w,
                        ))
                    .toList(),
              ),
            ),
          ],
          if (_tabController.index == 2) ...[
            verticalSpace(20.0),
            Container(height: 2, color: AppColors.lineColor),
            verticalSpace(20.0),
            Row(
              children: [
                PmlOutlineButton(
                  onTap: () {
                    dueInvoice = !dueInvoice;
                    dueInvoiceChecked = dueInvoice ? "" : null;
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
          child: currentSelectedTab == "CP Lead"
              ? PmlButton(
                  text: "CP Lead",
                  height: 28.0,
                  textStyle: textStyleWhite12px500w,
                  color: AppColors.colorSecondary,
                  onTap: () {
                    currentSelectedTab = "CP Lead";
                    _tabController.index = 0;
                    setState(() {});
                  },
                )
              : PmlOutlineButton(
            text: "CP Lead",
                  height: 28.0,
                  textStyle: textStyle12px500w,
                  onTap: () {
                    currentSelectedTab = "CP Lead";
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
                    showTourWalking();

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
                    showTourWalking();

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
                    showTourBooking();
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
                    showTourBooking();
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
            text: '\n ${listOfBannerStrings.map((e) => e.bannerName).join("      \u2022      ")}',
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
        ).onClick(() {
          if (listOfBannerStrings.isNotEmpty) {
            String check = listOfBannerStrings.first.bannerName;
            if (check != "No event available") showDialogBanner();
          }
        }),
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

  void showDialogBanner() {
    showDialog<BannerDataList>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Wrap(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: AppColors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("Events", style: textStyle14px500w),
                        verticalSpace(10.0),
                        ...listOfBannerStrings.map((e) {
                          return Container(
                            color: AppColors.inputFieldBackgroundColor,
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(e.bannerName, style: textStyleSubText14px500w)),
                                    horizontalSpace(10.0),
                                    Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: AppColors.colorPrimary,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ).onClick(() {
                            Navigator.pop(context, e);
                          });
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).then((BannerDataList value) async {
      switch (value.bannerType) {
        case "1":
          BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
          baseProvider.setBottomNavScreen(Screens.kCPEventScreen);
          await Navigator.pushNamed(context, Screens.kCPEventScreen);
          baseProvider.setBottomNavScreen(Screens.kHomeScreen);

          break;
        case "2":
          BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
          baseProvider.setBottomNavScreen(Screens.kCurrentPromotionsScreen);
          await Navigator.pushNamed(context, Screens.kCurrentPromotionsScreen);
          baseProvider.setBottomNavScreen(Screens.kHomeScreen);
          break;
      }
    });
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

  Widget cardViewLead(AllLeadResponse leadData) {
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
                  baseProvider.setBottomNavScreen(Screens.kHomeScreen);
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
                    color: AppColors.green,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("${leadData.cpLeadStatus}", style: textStyleWhite14px600w),
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

    //filter Date form the response and add it to the Date list
    bookingList.where((element) => element.bookingDate != null).forEach((booking) => listOfYears.add(booking.bookingDate.toDate.year.toString()));

    if (bookingList.isNotEmpty) {
      bookingList.first.mapOfKeys.addAll({
        "homeBookingTitle": homeBookingTitle,
        "homeBookingStatus": homeBookingStatus,
        "homeBookingCall": homeBookingCall,
        "homeBookingWhatsapp": homeBookingWhatsapp,
        "homeBookingUnit": homeBookingUnit,
      });
    }

    setState(() {});
  }

  void showTourWalking() async {
    bool completed = await Utility.isTourCompleted(Screens.kWalkingTour);
    if (!completed && walkinTutorialCoachMark == null && walkInList.isNotEmpty) {
      createTutorialWalking();
      await Future.delayed(Duration(milliseconds: 400));
      walkinTutorialCoachMark.show(context: context);
    }
  }

  void showTourBooking() async {
    bool completed = await Utility.isTourCompleted(Screens.kBookingTour);
    if (!completed && bookingTutorialCoachMark == null && bookingList.isNotEmpty) {
      createTutorialBooking();
      await Future.delayed(Duration(milliseconds: 400));
      bookingTutorialCoachMark.show(context: context);
    }
  }

  void createTutorialWalking() {
    walkinTutorialCoachMark = TutorialCoachMark(
      targets: _createTargetsWalking(),
      colorShadow: AppColors.colorPrimary,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Create Tutorial findish");
        Utility.setTourCompleted(Screens.kWalkingTour);
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
        print("skip");
      },
    );
  }

  void createTutorialBooking() {
    bookingTutorialCoachMark = TutorialCoachMark(
      targets: _createTargetBooking(),
      colorShadow: AppColors.colorPrimary,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Create Tutorial findish");
        Utility.setTourCompleted(Screens.kBookingTour);
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
        print("skip");
      },
    );
  }


  List<TargetFocus> _createTargetsWalking() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "homeWalkingTitle",
        keyTarget: homeWalkingTitle,
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
                  Text("Walking Customer Name", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeWalkingRating",
        keyTarget: homeWalkingRating,
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
                  Text("Walking customer conversion rating", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeWalkingValidity",
        keyTarget: homeWalkingValidity,
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
                  Text("Shows validity of walking customer", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeWalkingCalendar",
        keyTarget: homeWalkingCalendar,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Schedule visit", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeWalkingCall",
        keyTarget: homeWalkingCall,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Call customer", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeWalkingWhatsapp",
        keyTarget: homeWalkingWhatsapp,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Chat with customer", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeWalkingTaggingStatus",
        keyTarget: homeWalkingTaggingStatus,
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
                  Text("Customer tagging status", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }

  List<TargetFocus> _createTargetBooking() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "homeBookingTitle",
        keyTarget: homeBookingTitle,
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
                  Text("Booked customer Name", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeBookingStatus",
        keyTarget: homeBookingStatus,
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
                  Text("Booked customer status", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeBookingCall",
        keyTarget: homeBookingCall,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Call Customer", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeBookingWhatsapp",
        keyTarget: homeBookingWhatsapp,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Chat with Customer", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "homeBookingUnit",
        keyTarget: homeBookingUnit,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Get Unit details", style: textStyleWhite14px600w),
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
  void onWalkInListFetched(List<BookingResponse> wList) {
    walkInList.clear();
    walkInList.addAll(wList);
    //filter project form the response and add it to the project list
    walkInList.forEach((booking) => addProjectListValue(booking.projectInterested));
    walkInList.where((element) => element.walkingDate != null).forEach((booking) => listOfYears.add(booking.walkingDate.toDate.year.toString()));

    if (walkInList.isNotEmpty) {
      walkInList.first.mapOfKeys.addAll({
        "homeWalkingTitle": homeWalkingTitle,
        "homeWalkingRating": homeWalkingRating,
        "homeWalkingValidity": homeWalkingValidity,
        "homeWalkingCalendar": homeWalkingCalendar,
        "homeWalkingCall": homeWalkingCall,
        "homeWalkingWhatsapp": homeWalkingWhatsapp,
        "homeWalkingTaggingStatus": homeWalkingTaggingStatus,
      });
    }

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
  void onEventFetched(List<BannerDataList> brList) {
    listOfBannerStrings.clear();
    listOfBannerStrings.addAll(brList);
    if (listOfBannerStrings.isEmpty) listOfBannerStrings.add(BannerDataList(bannerName: "No event available"));
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

  int totalCustomerCount() {
    return bookingList.length + walkInList.length;
  }

  void addProjectListValue(String val) {
    if (val != null && projectList.contains(val) == false) {
      projectList.add(val);
    }
  }

  List<Widget> getLeadListByFilterValue() {
    List<Widget> listOfWidgets = [];

    listOfWidgets = listOfLeads
        .where((element) {
          int targetQuarter = getQuarterNumber(filterQuarter);
          if (targetQuarter == -1) return true;

          int year = element.dateFilter.toDate.year;
          int month = element.dateFilter.toDate.month;
          int monthsPerQuarter = 3; // Assuming 3 months per fiscal quarter

          // Calculate fiscal year and quarter
          int fiscalYear = month < fiscalYearStartMonth ? year - 1 : year;
          int fiscalMonth = (month - fiscalYearStartMonth + 12) % 12;
          int fiscalQuarter = (fiscalMonth ~/ monthsPerQuarter) + 1;

          return fiscalQuarter == targetQuarter;
        })
        .where((element) => filterYear == null || filterYear == element.dateFilter.toDate.year.toString()) // filter years
        .where((element) => filterValue == null || filterValue == element.projectInterested) // filter out by project
        .map<Widget>((element) => cardViewLead(element)) // convert to map then to widget
        .toList(); // provide list

    return listOfWidgets;
  }

  List<Widget> getWalkInListByFilterValue() {
    List<Widget> walkInWidgetList = [];

    walkInWidgetList = walkInList
        .where((element) => filterValue == null || filterValue == element.projectInterested) // filter out by project
        .where((element) => filterYear == null || filterYear == element.walkingDate.toDate.year.toString()) // filter years
        .where((element) {
          int targetQuarter = getQuarterNumber(filterQuarter);
          if (targetQuarter == -1) return true;

          int year = element.walkingDate.toDate.year;
          int month = element.walkingDate.toDate.month;
          int monthsPerQuarter = 3; // Assuming 3 months per fiscal quarter

          // Calculate fiscal year and quarter
          int fiscalYear = month < fiscalYearStartMonth ? year - 1 : year;
          int fiscalMonth = (month - fiscalYearStartMonth + 12) % 12;
          int fiscalQuarter = (fiscalMonth ~/ monthsPerQuarter) + 1;

          return fiscalQuarter == targetQuarter;
        })
        .map((element) => WalkInCardWidget(element, _homePresenter)) // convert to map then to widget
        .toList(); // provide list

    return walkInWidgetList;
  }

  List<Widget> getBookingListByFilterValue() {
    return bookingList
        .where((element) => filterValue == null || filterValue == element.projectFinalized) // filter out by project
        .where((element) => filterYear == null || filterYear == element.bookingDate.toDate.year.toString()) // filter out by project
        .where((element) {
          int targetQuarter = getQuarterNumber(filterQuarter);
          if (targetQuarter == -1) return true;

          int year = element.bookingDate.toDate.year;
          int month = element.bookingDate.toDate.month;
          int monthsPerQuarter = 3; // Assuming 3 months per fiscal quarter

          // Calculate fiscal year and quarter
          int fiscalYear = month < fiscalYearStartMonth ? year - 1 : year;
          int fiscalMonth = (month - fiscalYearStartMonth + 12) % 12;
          int fiscalQuarter = (fiscalMonth ~/ monthsPerQuarter) + 1;

          return fiscalQuarter == targetQuarter;
        })
        .where((element) => dueInvoiceChecked == null || dueInvoice == element.dueInvoice)
        .map((element) => BookingCardWidget(element, _homePresenter)) // convert to map then to widget
        .toList(); // provide list
  }

  int getQuarterNumber(String q) {
    switch (q) {
      case "Q1":
        return 1;
      case "Q2":
        return 2;
      case "Q3":
        return 3;
      case "Q4":
        return 4;
    }
    return -1;
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
    _homePresenter.getCurrentPromotionBlocker(context);
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
    // events = "Currently no events available";
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
      listOfYears.add(lead.dateFilter.toDate.year.toString());
    });
    // listOfLeads.forEach((booking) => listOfMonths.add(booking.));
    setState(() {});
  }

  @override
  void onLeadDeleted(AllLeadResponse response) {
    listOfLeads.remove(response);
    setState(() {});
  }

  @override
  void onCurrentPromotionPageBlockerDataFetched(List<PageBlockerList> pageBlockersImagesList) {
    if (pageBlockersImagesList == null || pageBlockersImagesList.isEmpty) return;

    if (kReleaseMode) dialogz(pageBlockersImagesList);
  }

  void dialogz(List<PageBlockerList> pageBlockersImagesList) {
    int totalLength = pageBlockersImagesList.length - 1;
    if (currentPromoShowing == false)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          int indexOfCurrentImage = 0;
          return StatefulBuilder(builder: (context, alertDialogState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              insetPadding: EdgeInsets.zero,
              actions: <Widget>[
                if (indexOfCurrentImage == totalLength)
                  Center(
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      // padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Icon(Icons.close, size: 14, color: AppColors.colorPrimary),
                    ).onClick(() {
                      Navigator.pop(context);
                    }),
                  ),
                verticalSpace(20.0),
                Stack(
                  children: [
                    Container(
                      key: currentPromoPageBlockerBtnKey,
                      width: Utility.screenWidth(context),
                      height: Utility.screenWidth(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          child: CachedImageWidget(
                            imageUrl: pageBlockersImagesList[indexOfCurrentImage].imageURL,
                            radius: 0.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 20,
                      child: InkWell(
                        onTap: () {
                          Utility.launchUrlX(context, pageBlockersImagesList[indexOfCurrentImage].imageURL);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black.withOpacity(0.5),
                          ),
                          child: Image.asset(Images.kIconRedirect),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35.0,
                      height: 35.0,
                      // padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Icon(Icons.arrow_back_ios, size: 14),
                    ).onClick(() {
                      if (indexOfCurrentImage > 0) {
                        indexOfCurrentImage--;
                      }
                      alertDialogState(() {});
                    }),
                    horizontalSpace(20.0),
                    Text("${indexOfCurrentImage + 1}/${pageBlockersImagesList.length}", style: textStyleWhite14px600w),
                    horizontalSpace(20.0),
                    Container(
                      width: 35.0,
                      height: 35.0,
                      // padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Icon(Icons.arrow_forward_ios, size: 14),
                    ).onClick(() {
                      if (indexOfCurrentImage < pageBlockersImagesList.length - 1) {
                        indexOfCurrentImage++;
                      }
                      alertDialogState(() {});
                    }),
                  ],
                )
              ],
            );
          });
        },
      ).then((value) {
        currentPromoShowing = false;
      });
    currentPromoShowing = true;
  }
}

/*

  bool filterBooking(BookingResponse element) {
    // Apply the first filter
    bool isFilterValueValid = filterValue == null || filterValue == element.projectFinalized;

    // Apply the second filter
    bool isDueInvoiceValid = dueInvoice == element.dueInvoice;

    // Apply the third filter
    bool isFilterDateValid = filterDate == element.bookingDate;

    bool combination1 = isFilterValueValid;
    bool combination2 = isDueInvoiceValid;
    bool combination3 = isFilterDateValid;

    bool combination4 = isFilterValueValid && isDueInvoiceValid;
    bool combination5 = isFilterValueValid && isFilterDateValid;
    bool combination6 = isDueInvoiceValid && isFilterDateValid;

    bool combination7 = isFilterValueValid && isDueInvoiceValid && isFilterDateValid;

    bool combination8 = isDueInvoiceValid && isFilterDateValid && !isFilterValueValid;
    bool combination9 = isFilterValueValid && isFilterDateValid && !isDueInvoiceValid;
    bool combination10 = isFilterValueValid && isDueInvoiceValid && !isFilterDateValid;

    bool combination11 = isFilterValueValid || isDueInvoiceValid && !isFilterDateValid;
    bool combination12 = isDueInvoiceValid || isFilterDateValid && !isFilterValueValid;
    bool combination13 = isFilterDateValid || isFilterValueValid && !isDueInvoiceValid;

    bool combination14 = false;

    // Check if any combination is true
    return combination1 ||
        combination2 ||
        combination3 ||
        combination4 ||
        combination5 ||
        combination6 ||
        combination7 ||
        combination8 ||
        combination9 ||
        combination10 ||
        combination11 ||
        combination12 ||
        combination13 ||
        combination14;
  }




InkWell(
                        onTap: () {
                          filterValue = e == filterValue ? null : e;
                          setState(() {});
                        },
                        child: Container(
                          color: filterValue == e ? AppColors.colorSecondary : AppColors.screenBackgroundColor,
                          child: Text(
                            "$e",
                            style: filterValue == e ? textStyleWhite12px500w : textStyle12px500w,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(right: 10.0),
                          height: 25.0,
                        ),
                      )
* */