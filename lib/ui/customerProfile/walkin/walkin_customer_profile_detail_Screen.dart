import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_presenter.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/chatresponse.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/walkin_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/left_chat_widget.dart';
import 'widget/right_chat_widget.dart';

class WalkinCustomerProfileDetailScreen extends StatefulWidget {
  final BookingResponse response;

  WalkinCustomerProfileDetailScreen(this.response, {Key key}) : super(key: key);

  @override
  _WalkinCustomerProfileDetailScreenState createState() => _WalkinCustomerProfileDetailScreenState();
}

class _WalkinCustomerProfileDetailScreenState extends State<WalkinCustomerProfileDetailScreen> implements WalkinView {
  CustomerProfilePresenter presenter;
  List<Chatresponse> chatlist = [];
  String comment;

  CustomerProfilePresenter _homePresenter;

  @override
  void initState() {
    presenter = CustomerProfilePresenter(this);
    presenter.getCommentList(context, widget.response.sfdcid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      child: ListView(
        children: [
          verticalSpace(20.0),
          //customer pic with name and time
          Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(80.0),
              //   child: Container(
              //     height: 37,
              //     width: 37,
              //     child: Image.asset(Images.kImgPlaceholder, fit: BoxFit.fill),
              //   ),
              // ),
              // horizontalSpace(8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.response?.name}", style: textStyleRegular18pxW500),
                  Text("Next Follow up: Not Available", style: textStyleSubText14px500w),
                ],
              ),
            ],
          ),

          //calender call whatsapp
          verticalSpace(12.0),
          Row(
            children: [
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorPrimaryLight,
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(Images.kIconCalender),
                ),
              ),
              horizontalSpace(8.0),
              InkWell(
                onTap: () {
                  launch("tel://${widget.response?.name ?? ""}");
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorPrimaryLight,
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(Images.kIconPhone),
                ),
              ),
              horizontalSpace(8.0),
              WhatsAppButton("${widget.response?.mobilenumber}"),
            ],
          ),

          //chip layout
          verticalSpace(12.0),
          Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Utility.getRatingColor(widget.response?.newRating),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("${widget.response?.newRating}", style: textStyleWhite14px500w),
                ),
                horizontalSpace(10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.chipColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("Validity: ${widget.response?.createdDays} Days", style: textStyle14px500w),
                ),
                horizontalSpace(10.0),
                if (widget.response.revisit)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.chipColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Text("Revisit", style: textStyle14px500w),
                  ),
              ],
            ),
          ),

          if (chatlist.isEmpty) ...[
            verticalSpace(20.0),
            line(),
            verticalSpace(150.0),
            Center(child: Text("No Visit Found", style: textStyleRegular16px500w)),
          ],

          //Chat
          if (chatlist.isNotEmpty)
            for (int i = 0; i < chatlist.length; i++) chatCardView(chatlist[i], i + 1),
          // ...(chatlist.map<Widget>((e) => chatCardView(e)).toList())
        ],
      ),
    );
  }

  getFormattedDate(String date) {
    if (date == null) return "";
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat("MMM dd, yyyy").format(dateTime);
    return formattedDate;
  }

  chatCardView(Chatresponse chatresponse, int no) {
    String dateFormatter = getFormattedDate(chatresponse.dateOfVisit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Comment layout
        verticalSpace(25.0),
        line(),
        verticalSpace(10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Visit No. $no", style: textStyle20px500w),
            horizontalSpace(12.0),
            Text("$dateFormatter", style: textStyleSubText14px500w),
            Spacer(),
            InkWell(
              onTap: () {
                showDetailDialog(context, chatresponse);
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorSecondary,
                ),
                child: Icon(Icons.add, color: AppColors.white),
              ),
            ),
          ],
        ),

        verticalSpace(20.0),

        ...commentBuilder(chatresponse?.allFeedbacks),
      ],
    );
  }

  commentBuilder(String allComments) {
    List<Widget> commentWidgets = [];
    if (allComments == null || allComments.isEmpty) {
      commentWidgets.add(Text("No Data"));
      return commentWidgets;
    }

    List<String> s = allComments.split("\r");
    List<String> temp = [];
    temp.clear();
    temp.addAll(s.reversed);
    s.clear();
    s.addAll(temp);

    for (String c in s) {
      commentWidgets.add(verticalSpace(10.0));
      if (c.endsWith("(CP)")) {
        commentWidgets.add(Align(alignment: Alignment.centerRight, child: RightChatWidget(c)));
        print("cp comment --- $c");
      } else {
        commentWidgets.add(LeftChatWidget(
          name: "Maryam Kapur (SM)",
          chatText: "$c",
        ));
        print("SM comment --- $c");
      }
    }
    return commentWidgets;
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onInvoiceDetailFetched(InvoiceResponse projectUnitResponse) {}

  @override
  void onProjectUnitResponseFetched(ProjectUnitResponse projectUnitResponse) {}

  @override
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse) {}

  @override
  onWalkinCommentFetched(List<Chatresponse> projectListResponse) {
    chatlist.clear();
    chatlist.addAll(projectListResponse);
    setState(() {});
  }

  final subTextStyle = textStyleSubText14px500w;

  void showDetailDialog(BuildContext context, Chatresponse chatResponse) {
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type comment",
                          hintStyle: subTextStyle,
                          isDense: true,
                          suffixStyle: TextStyle(color: AppColors.textColor),
                        ),
                        onChanged: (String val) {
                          comment = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              PmlButton(
                width: 150,
                height: 30,
                text: "Add Comment",
                color: AppColors.colorPrimary,
                onTap: () {
                  if (comment != null && comment.isNotEmpty) {
                    presenter.addComments(
                      context,
                      comment,
                      widget.response.sfdcid,
                      chatResponse.siteVisitID,
                    );
                  } else {
                    onError("Please enter comment");
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

  @override
  onCommentAddError(String error) {
    onError(error);
  }

  @override
  void onCommentAdded() {
    Navigator.pop(context);
    presenter.getCommentList(context, widget?.response?.sfdcid);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _selectTime(context, picked);
    }
  }

  Future<Null> _selectTime(BuildContext context, DateTime datePicked) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    DateTime x = DateTime(
      datePicked.year,
      datePicked.month,
      datePicked.day,
      picked.hour,
      picked.minute,
      datePicked.second,
      datePicked.millisecond,
      datePicked.microsecond,
    );

    if (picked != null) {
      presenter.scheduleTime(context, widget.response.sfdcid, x);
    }
  }

  @override
  void onNoVisitFound() {
    print("no visit found");
    print("no visit found");
  }
}
