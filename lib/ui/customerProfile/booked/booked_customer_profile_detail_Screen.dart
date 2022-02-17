import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_presenter.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedCustomerProfileDetailScreen extends StatefulWidget {
  final BookingResponse response;

  BookedCustomerProfileDetailScreen(this.response, {Key key}) : super(key: key);

  @override
  _BookedCustomerProfileDetailScreenState createState() => _BookedCustomerProfileDetailScreenState();
}

class _BookedCustomerProfileDetailScreenState extends State<BookedCustomerProfileDetailScreen> implements CustomerProfileView {
  CustomerProfilePresenter _homePresenter;
  InvoiceResponse response;

  @override
  void initState() {
    _homePresenter = CustomerProfilePresenter(this);
    // _homePresenter.getWalkInList(context);
    _homePresenter.getInvoice(context, widget?.response?.sfdcid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.0),
              //customer pic with name and time
              Text("${widget.response?.name}", style: textStyleRegular18pxW500),
              Text("Next Follow up: Not Available", style: textStyleSubText14px500w),

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
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(6),
                    //     color: Utility.getRatingColor(widget.response?.newRating),
                    //   ),
                    //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    //   child: Text("${widget.response?.newRating}", style: textStyleWhite14px500w),
                    // ),
                    // horizontalSpace(10.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.chipColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("Validity: ${widget.response?.createdDays} Days", style: textStyle14px500w),
                    ),
                    if (widget?.response?.revisit ?? false) ...[
                      horizontalSpace(10.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.chipColor,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        child: Text("Revisit", style: textStyle14px500w),
                      )
                    ],
                    horizontalSpace(10.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.chipColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("Validity: ${widget.response?.projectFinalized} Days", style: textStyle14px500w),
                    ),
                  ],
                ),
              ),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Booked", style: textStyle20px500w),
                  horizontalSpace(12.0),
                  Text("On March 21th, 2021", style: textStyleSubText14px500w),
                  Spacer(),
                  PmlButton(
                    width: 30,
                    height: 30,
                    color: AppColors.colorSecondary,
                    child: Icon(Icons.add, color: AppColors.white, size: 16.0),
                    onTap: () {
                      _homePresenter.getCustomerUnitDetail(context, widget?.response?.sfdcid);
                    },
                  ),
                ],
              ),
              verticalSpace(25.0),
              InkWell(
                onTap: () async {
                  Utility.launchUrlX(context, response.file);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                  color: AppColors.screenBackgroundColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Download Invoice", style: textStyleRegular16px500px),
                      Icon(Icons.arrow_circle_down_outlined, size: 14.0, color: AppColors.colorSecondary),
                    ],
                  ),
                ),
              ),
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

        verticalSpace(30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Image.asset(getInvoiceProgress()),
        ),

        verticalSpace(30.0),
        line(),
      ],
    );
  }

  // 9.9% received
  // Eligible to raise Invoice
  // Invoice Approved
  // Payment Released
  String getInvoiceProgress() {
    switch (response?.status) {
      case "9.9% received":
        return Images.kImagePD1;
      case "Invoice Approved":
        return Images.kImagePD2;
      case "Eligible to raise Invoice":
        return Images.kImagePD3;
      case "Payment Released":
        return Images.kImagePD4;
      default:
        return Images.kImagePD1;
        break;
    }
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
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse) {
    Utility.showSuccessToastB(context, "Visit Scheduled");
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
      _homePresenter.scheduleTime(context, widget.response.sfdcid, x);
    }
  }

  @override
  void onProjectUnitResponseFetched(ProjectUnitResponse projectUnitResponse) {
    showDetailDialog(projectUnitResponse);
  }

  void showDetailDialog(ProjectUnitResponse projectUnitResponse) {
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
                buildDialogRow("Unit Number", "${projectUnitResponse?.apartmentFinalized}"),
                buildDialogRow("Tower", "${projectUnitResponse?.towerFinalized}"),
                buildDialogRow("Carpet Area", "${projectUnitResponse?.carpetarea}"),
                buildDialogRow("Agreement Value", "${projectUnitResponse?.totalAgreementValue}"),
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

  @override
  void onInvoiceDetailFetched(InvoiceResponse projectUnitResponse) {
    response = projectUnitResponse;
    setState(() {});
  }
}
