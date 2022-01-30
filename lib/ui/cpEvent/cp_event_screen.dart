import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_presenter.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_view.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_status_update_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class CPEventScreen extends StatefulWidget {
  const CPEventScreen({Key key}) : super(key: key);

  @override
  _CPEventScreenState createState() => _CPEventScreenState();
}

class _CPEventScreenState extends State<CPEventScreen> implements CPEventView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  final List<CpEventResponse> cpEventList = [];
  CPEventPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = CPEventPresenter(this);
    presenter.getEventList(context);
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.18;

    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(22.0),
            Text("CP Events (${cpEventList.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: ListView(
                children: cpEventList.map<Widget>((e) => eventCardView(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  eventCardView(CpEventResponse cpEventData) {
    return Container(
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
          Container(
            height: 130.0,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Images.kImgEventPlaceholder1),
              fit: BoxFit.fill,
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${cpEventData.eventName}", style: textStyle24px500w),
                verticalSpace(10.0),
                Row(
                  children: [
                    Image.asset(Images.kIconCpEventCalender, height: 16),
                    horizontalSpace(10.0),
                    Text("${getFormattedDate(cpEventData.eventDatetime)}", style: textStyle14px500w),
                    horizontalSpace(25.0),
                    Image.asset(Images.kIconClock, height: 16),
                    horizontalSpace(10.0),
                    Text("${getFormattedTime(cpEventData.eventDatetime)}", style: textStyle14px500w),
                  ],
                ),
                verticalSpace(20.0),
                Row(
                  children: [
                    PmlButton(
                      height: 32.0,
                      text: "Attend",
                      color: AppColors.attendButtonColor,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      onTap: () {
                        presenter.revertToEvent(context, "Attend", cpEventData.cpeventId);
                      },
                    ),
                    horizontalSpace(10.0),
                    PmlButton(
                      height: 32.0,
                      text: "Tentative",
                      color: AppColors.tentativeButtonColor,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      onTap: () {
                        presenter.revertToEvent(context, "Tentative", cpEventData.cpeventId);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          verticalSpace(10.0),
        ],
      ),
    );
  }

  getFormattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat("MMM dd, yyyy").format(dateTime);
    return formattedDate;
  }

  getFormattedTime(String dTime) {
    DateTime dateTime = DateTime.parse(dTime);
    String formattedDate = DateFormat("hh:mm a").format(dateTime);
    return formattedDate;
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onEventFetched(List<CpEventResponse> response) {
    cpEventList.clear();
    cpEventList.addAll(response);
    setState(() {});
  }

  @override
  void onCpEventStatusUpdated(CpEventStatusUpdateResponse response) {
    Utility.showSuccessToastB(context, response.availabilityStatus);
  }
}

/*



 Text("Previous Events", style: textStyle20px500w),
                  verticalSpace(10.0),
                  Container(
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
                        Container(
                          height: 130.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(Images.kImgEventPlaceholder),
                            fit: BoxFit.fill,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Revanta - Ravik Launch Event", style: textStyle24px500w),
                              verticalSpace(10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),



*/
