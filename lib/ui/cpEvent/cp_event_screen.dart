import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CPEventScreen extends StatefulWidget {
  const CPEventScreen({Key key}) : super(key: key);

  @override
  _CPEventScreenState createState() => _CPEventScreenState();
}

class _CPEventScreenState extends State<CPEventScreen> implements CPEventView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  static const ATTEND = "Attend";
  static const TENTATIVE = "Tentative";
  static const String NOT_GOING = "Not Going";

  final List<CpEventResponse> cpEventList = [];
  CPEventPresenter presenter;
  String comment;
  String size = "0";

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
              child: RefreshListView(
                onRefresh: () {
                  presenter.getEventList(context);
                },
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
              image: /*NetworkImage("${cpEventData?.eventImage??""}") */ MemoryImage(
                  Utility.convertMemoryImage(cpEventData.eventImage)),
              fit: BoxFit.fill,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${cpEventData.eventName}", style: textStyle24px500w),
                verticalSpace(10.0),
                Wrap(
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
                if (cpEventData.availabilitystatus != null)
                  Container(
                    height: 25.0,
                    color:
                        cpEventData.availabilitystatus == ATTEND ? AppColors.attendButtonColor : AppColors.tentativeButtonColor,
                    child: Center(child: Text("${eventText(cpEventData.availabilitystatus)}", style: textStyleWhite14px500w)),
                  ),
                if (cpEventData.availabilitystatus == null /*true*/)
                  Row(
                    children: [
                      PmlButton(
                        height: 32.0,
                        text: "Attend",
                        color: AppColors.attendButtonColor,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        onTap: () {
                          showDetailDialog(cpEventData, "Attend", size);
                        },
                      ),
                      horizontalSpace(10.0),
                      PmlButton(
                        height: 32.0,
                        text: "Tentative",
                        color: AppColors.tentativeButtonColor,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        onTap: () {
                          showDetailDialog(cpEventData, "Tentative", size);
                          // presenter.revertToEvent(context, "Tentative", cpEventData.cpeventId);
                        },
                      ),
                      horizontalSpace(10.0),
                      PmlButton(
                        height: 32.0,
                        text: "Not Going",
                        color: AppColors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        onTap: () {
                          presenter.revertToEvent(context, "Not Going", size, cpEventData.cpeventId);
                        },
                      ),
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
    if (date == null || date.isEmpty) return "";

    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat("MMM dd, yyyy").format(dateTime);
    return formattedDate;
  }

  getFormattedTime(String dTime) {
    print(dTime);
    if (dTime == null || dTime.isEmpty) return "";

    DateTime dateTime = DateTime.parse(dTime).toLocal();
    String formattedDate = DateFormat("hh:mm aa").format(dateTime);
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
    size = "0";
    if (response.availabilityStatus != "Not Going")
      Navigator.pop(context); // hide dialog

    presenter.getEventList(context);
    if (response.availabilityStatus != "Not Going") showZoomDialog(response?.zoomlink);
  }

  String eventText(String eventStatus) {
    switch (eventStatus) {
      case ATTEND:
        return "You are Attending this event";
      case TENTATIVE:
        return "You have tentatively accepted for event";
      case NOT_GOING:
        return "You are not going to this event";
    }
    return "";
  }

  void showDetailDialog(CpEventResponse cpEventData, String status, String size) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      content: Wrap(
        children: [
          Column(
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
                    Container(
                      color: AppColors.screenBackgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        obscureText: false,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.none,
                        style: subTextStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Pax Size",
                          hintStyle: subTextStyle,
                          isDense: true,
                          suffixStyle: TextStyle(color: AppColors.textColor),
                        ),
                        onChanged: (String val) {
                          size = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              PmlButton(
                width: 150,
                height: 30,
                text: "Next",
                color: AppColors.colorPrimary,
                onTap: () {
                  presenter.revertToEvent(context, status, size, cpEventData.cpeventId);
                },
              ),
              verticalSpace(20.0),
            ],
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

  void showZoomDialog(String zoomLink) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      content: Wrap(
        children: [
          Column(
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
                    Container(
                      color: AppColors.screenBackgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Please click on Next Button to register on the following meeting link to join the event",
                        style: textStyle12px500w,
                      ),
                    ),
                  ],
                ),
              ),
              PmlButton(
                width: 150,
                height: 30,
                text: "Next",
                color: AppColors.colorPrimary,
                onTap: () {
                  Navigator.pop(context);
                  if (zoomLink != null && zoomLink.isNotEmpty) {
                    bool hasHttp = zoomLink.startsWith("http") || zoomLink.startsWith("https");
                    zoomLink = hasHttp ? zoomLink : "https://${zoomLink}";
                    print(zoomLink);

                    launch(zoomLink);
                  } else {
                    onError("No link found!");
                  }
                },
              ),
              verticalSpace(20.0),
            ],
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
