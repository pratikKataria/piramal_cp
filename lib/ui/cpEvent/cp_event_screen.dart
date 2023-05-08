import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_presenter.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_tour_keys.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_view.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_status_update_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
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

  TutorialCoachMark globalTutorialCoachMark;

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
          AspectRatio(
            aspectRatio: 16/9,
            key: cpEventData.mapOfKeys["cpEventImage"],
            child: Container(
               decoration: BoxDecoration(
                  image: DecorationImage(
                image: MemoryImage(Utility.convertMemoryImage(cpEventData.eventImage)),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${cpEventData.eventName}",
                    key: cpEventData.mapOfKeys["cpEventTitle"],
                    style: textStyle24px500w),
                verticalSpace(10.0),
                Wrap(
                  key: cpEventData.mapOfKeys["cpEventDateTime"],
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
                        key: cpEventData.mapOfKeys["cpEventAttend"],
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        onTap: () {
                          showDetailDialog(cpEventData, "Attend", size);
                        },
                      ),
                      horizontalSpace(10.0),
                      PmlButton(
                        height: 32.0,
                        text: "Tentative",
                        key: cpEventData.mapOfKeys["cpEventTentative"],
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
                        key: cpEventData.mapOfKeys["cpEventNotGoing"],
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
    if (cpEventList.isNotEmpty) {
      cpEventList.first.mapOfKeys.addAll({
        "cpEventImage": cpEventImage,
        "cpEventTitle": cpEventTitle,
        "cpEventDateTime": cpEventDateTime,
        "cpEventAttend": cpEventAttend,
        "cpEventTentative": cpEventTentative,
        "cpEventNotGoing": cpEventNotGoing,
      });

      showTour();
    }
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

  void showTour() async {
    bool completed = await Utility.isTourCompleted(Screens.kCPEventScreen);
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
      hideSkip: true,
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
        print("skip");
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "cpEventImage",
        keyTarget: cpEventImage,
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
                  Text("Event Detail image", style: textStyleWhite14px600w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "cpEventTitle",
        keyTarget: cpEventTitle,
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
                  Text("Event Title", style: textStyleWhite14px600w),
                ],
              );
            },
          ),

        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "cpEventDateTime",
        keyTarget: cpEventDateTime,
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
                  Text("Event date and time", style: textStyleWhite14px600w),
                ],
              );
            },
          ),

        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "cpEventAttend",
        keyTarget: cpEventAttend,
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
                  Text("To attend event tap on Attend", style: textStyleWhite14px600w),
                ],
              );
            },
          ),

        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "cpEventTentative",
        keyTarget: cpEventTentative,
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
                  Text("When your are not sure of attending event tap on Tentative.", style: textStyleWhite14px600w),
                ],
              );
            },
          ),

        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "cpEventNotGoing",
        keyTarget: cpEventNotGoing,
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
                  Text("When your are not going tap on Not Going.", style: textStyleWhite14px600w),
                ],
              );
            },
          ),

        ],
      ),
    );
    return targets;
  }

}
