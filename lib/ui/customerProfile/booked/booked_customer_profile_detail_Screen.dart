import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/extension/extention%20function.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/constants.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/tour_keys_bottom_navigation.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/generate_invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_presenter.dart';
import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/download_button.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/invoice_number_request.dart';

class BookedCustomerProfileDetailScreen extends StatefulWidget {
  final BookingResponse response;

  BookedCustomerProfileDetailScreen(this.response, {Key key}) : super(key: key);

  @override
  _BookedCustomerProfileDetailScreenState createState() => _BookedCustomerProfileDetailScreenState();
}

class _BookedCustomerProfileDetailScreenState extends State<BookedCustomerProfileDetailScreen> implements CustomerProfileView {

  CustomerProfilePresenter _presenter;
  InvoiceResponse response;
  InvoiceNumberRequest _invoiceNumberRequest = InvoiceNumberRequest();
  List<InvoiceResponse> responseList = [];
  bool _invoiceGenerated = false;
  bool _invoiceNumberGenerated = false;

  TutorialCoachMark globalTutorialCoachMark;

  @override
  void initState() {
    _presenter = CustomerProfilePresenter(this);
    // _homePresenter.getWalkInList(context);
    _presenter.getInvoice(context, widget?.response?.sfdcid);
    super.initState();
  }

  void tour() async {
    bool completed = await Utility.isTourCompleted(Screens.kCustomerProfileDetailBooking);
    if (!completed && globalTutorialCoachMark == null) {
      createTutorial();
      showTutorial();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshListView(
      onRefresh: () {
        _presenter.getInvoice(context, widget?.response?.sfdcid);
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            key: bookedCustomerTopProfile,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10.0),
              //customer pic with name and time
              Text("${widget.response?.name}", style: textStyleRegular18pxW500),
              //calender call whatsapp
              verticalSpace(12.0),
              Row(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     _selectDate(context);
                  //   },
                  //   child: Container(
                  //     width: 35,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: AppColors.colorPrimaryLight,
                  //     ),
                  //     padding: EdgeInsets.all(10.0),
                  //     child: Image.asset(Images.kIconCalender),
                  //   ),
                  // ),
                  // horizontalSpace(8.0),
                  InkWell(
                    onTap: () {
                      launch("tel://${widget.response?.mobilenumber ?? ""}");
                    },
                    child: Container(
                      width: 32,
                      height: 32,
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
                    /* Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.chipColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("Validity: ${widget.response?.createdDays} Days", style: textStyle14px500w),
                    ),*/
                    if (widget?.response?.revisit ?? false) ...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.chipColor,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        child: Text("Revisit", style: textStyle14px500w),
                      ),
                      horizontalSpace(10.0),
                    ],
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.chipColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("${widget?.response?.projectFinalized ?? "NA"}", style: textStyle14px500w),
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
                  Row(
                    key: bookedCustomerDetails,
                    children: [
                      Text("Booked", style: textStyle20px500w),
                      horizontalSpace(12.0),
                      Text("On ${response?.bookingApprovalDate?.formatDate2}", style: textStyleSubText14px500w),
                    ],
                  ),
                  Spacer(),
                  PmlButton(
                    key: bookedCustomerUnitDetails,
                    width: 30,
                    height: 30,
                    color: AppColors.colorSecondary,
                    child: Icon(Icons.add, color: AppColors.white, size: 16.0),
                    onTap: () {
                      _presenter.getCustomerUnitDetail(context, widget?.response?.sfdcid);
                    },
                  ),
                ],
              ),
              verticalSpace(25.0),

              //Invoice number input layout
              if ((response?.showInvoiceNumber ?? false) && !_invoiceNumberGenerated) invoiceNumberInput(),

              //Generate invoice layout
              if (_invoiceNumberGenerated && !_invoiceGenerated) generateInvoiceWidget(),

              //Download invoice layout
              if (_invoiceNumberGenerated && _invoiceGenerated) downloadButtonWidget(),

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

        verticalSpace(20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            key: bookedCustomerProgressStatus,
            children: [
              ...timelineViewBuilder(),
            ],
          ),
        ),

        verticalSpace(30.0),
        line(),
      ],
    );
  }

  Container generateInvoiceWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      margin: EdgeInsets.only(bottom: 25.0),
      color: AppColors.screenBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Generate Invoice", style: textStyleRegular16px500px),
          PmlButton(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(8.0),
            onTap: () => _presenter.postGenerateInvoice(context, widget?.response?.sfdcid, response?.brokerageID),
            child: Image.asset(
              Images.kIconDownload,
            ),
          )
        ],
      ),
    );
  }

  Container downloadButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      margin: EdgeInsets.only(bottom: 25.0),
      color: AppColors.screenBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Download Invoice", style: textStyleRegular16px500px),
          PmlButton(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(8.0),
            onTap: () => _presenter.getTermsAndCondition(context),
            child: Image.asset(Images.kIconDownload),
          )
        ],
      ),
    );
  }

  List<Column> timelineViewBuilder() {
    List<Column> colList = [];

    int currentStatusIndex = 99;
    responseList?.forEach((element) {
      if (element.currentStatus == element.status) currentStatusIndex = element.position;
      print("elemen positon ${element.position} current status position $currentStatusIndex");
      colList.insert(
        element.position,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (element.position != 0)
              Container(
                width: 2.0,
                height: 50.0,
                margin: EdgeInsets.only(left: 3.4),
                decoration: BoxDecoration(
                  color: element.position <= currentStatusIndex ? AppColors.black : AppColors.textColorHeather,
                ),
              ),
            Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: element.position <= currentStatusIndex ? AppColors.black : AppColors.textColorHeather,
                  ),
                ),
                horizontalSpace(10.0),
                Text(
                  element?.status ?? "",
                  style: element.position <= currentStatusIndex ? textStyleBlack10px500w : textStyleSubText10px500w,
                )
              ],
            ),
          ],
        ),
      );
    });

    return colList;
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

  Container invoiceNumberInput() {
    return Container(
      height: 38,
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 75,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Invoice", style: textStyle14px500w),
          ),
          Expanded(
            child: TextFormField(
              // obscureText: true,
              textAlign: TextAlign.left,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: textStyleSubText14px500w,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter invoice number",
                hintStyle: textStyleSubText14px500w,
                isDense: true,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                _invoiceNumberRequest.invoiceNumber = val;
              },
            ),
          ),
          InkWell(
            onTap: () {
              _invoiceNumberRequest.brokerId = response?.brokerageID;
              _invoiceNumberRequest.otyId = widget?.response?.sfdcid;

              if ((_invoiceNumberRequest?.invoiceNumber ?? "").isEmpty)
                onError("Please enter Invoice number");
              else
                _presenter.postSaveInvoiceNumber(context, _invoiceNumberRequest);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Save", style: textStylePrimary14px500w),
            ),
          )
        ],
      ),
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
      _presenter.scheduleTime(context, widget.response.sfdcid, x);
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
                Text("Unit details", style: textStyle14px500w),
                buildDialogRow("Unit Number", "${projectUnitResponse?.apartmentFinalized}"),
                buildDialogRow("Tower", "${projectUnitResponse?.towerFinalized}"),
                buildDialogRow("Carpet Area", "${projectUnitResponse?.carpetarea}"),
                buildDialogRow("Agreement Value", "${projectUnitResponse?.totalAgreementValue}"),
                verticalSpace(10.0),
             /*   Text("Payment details", style: textStyle14px500w),
                buildDialogRow("Payment to Broker by BN Status", "${projectUnitResponse?.paymentToBrokerByBNStatus ?? ""}"),
                buildDialogRow("Payment date", "${projectUnitResponse?.paymentDate ?? ""}"),
                buildDialogRow("Amount Paid", "${projectUnitResponse?.amountPaid ?? ""}"),
                buildDialogRow("Payment detail", "${projectUnitResponse?.paymentDetail ?? ""}"),
                verticalSpace(10.0),
                if (projectUnitResponse?.paymentByBN ?? false)
                  PmlButton(
                    height: 30.0,
                    text:
                        !(projectUnitResponse?.paymentConfirmationByCP ?? false) ? "Acknowledge Payment" : "Payment Acknowledged",
                    color: !(projectUnitResponse?.paymentConfirmationByCP ?? false)
                        ? AppColors.colorPrimary
                        : AppColors.colorPrimary.withOpacity(0.5),
                    onTap: () async {
                      if (!(projectUnitResponse?.paymentConfirmationByCP ?? false)) {
                        _presenter.acknowledgePayment(context, widget?.response?.sfdcid, response.brokerageID);
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

  @override
  void onInvoiceDetailFetched(List<InvoiceResponse> projectUnitResponse) {
    // response = projectUnitResponse;
    if (projectUnitResponse.isNotEmpty) response = projectUnitResponse.first;
    responseList.clear();
    responseList.addAll(projectUnitResponse);

    //check for invoice number is saved or not also check for generated invoice
    _invoiceGenerated = response?.generatedInvoice ?? false;
    _invoiceNumberGenerated = response?.invoiceNumberGenerated ?? false;

    tour();
    setState(() {});
  }

  @override
  void onInvoiceGenerated(GenerateInvoiceResponse bookingResponse) {
    _invoiceGenerated = true;
    Utility.showSuccessToastB(context, "Invoice generated");
    setState(() {});
  }

  @override
  void onTermsAndConditionFetched(String message) {
    showTermsAndConditionDialog(message);
    setState(() {});
  }

  void showTermsAndConditionDialog(String message) {
    bool termsAndConditionValue = false;
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white,
      scrollable: true, // <-- Set it to true
      content: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) ss) {
          return Container(
            width: double.maxFinite,
            child: Column(
              children: [
                verticalSpace(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PmlButton(
                      width: 30,
                      height: 30,
                      color: AppColors.colorPrimary,
                      child: Icon(Icons.close, color: AppColors.white, size: 16.0),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Text(message ?? "", style: textStyle14px500w),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                  margin: EdgeInsets.only(bottom: 25.0),
                  color: AppColors.screenBackgroundColor,
                  child: Column(
                    children: [
                      if (termsAndConditionValue)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Download Invoice", style: textStyle14px500w),
                            Spacer(),
                            DownloadButton("${response?.brokerageID}", Constants.INVOICE, onActionComplete: () {
                              Navigator.pop(context);
                            }),
                            horizontalSpace(4.0),
                          ],
                        ),
                      CheckboxListTile(
                        value: termsAndConditionValue,
                        contentPadding: EdgeInsets.all(0.0),
                        title: Text("I accept the Terms And Condition", style: textStyle14px500w),
                        onChanged: (value) {
                          termsAndConditionValue = value;
                          ss(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showTutorial() {
    globalTutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    globalTutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: AppColors.colorPrimary,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        // Utility.setTourCompleted(Screens.kCustomerProfileDetailBooking);
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
        Utility.setTourCompleted(Screens.kCustomerProfileDetailBooking);
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
        identify: "keyBottomNavigation11",
        keyTarget: bookedCustomerTopProfile,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,

            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("User Profile", style: textStyleWhite14px600w),
                  Text("Customer details", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation111",
        keyTarget: bookedCustomerDetails,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,

            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Booking Details", style: textStyleWhite14px600w),
                  // Text("Check booking date, invoice status, generate invoice.", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "bookedCustomerUnitDetails",
        keyTarget: bookedCustomerUnitDetails,
        alignSkip: Alignment.topRight,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,

            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Unit details", style: textStyleWhite14px600w),
                  Text("Tower Name, Unit Number, Payment date, Amount and others", style: textStyleWhite14px500w),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "bookedCustomerProgressStatus",
        keyTarget: bookedCustomerProgressStatus,
        alignSkip: Alignment.topRight,
        radius: 5,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,

            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  // Text("Timeline", style: textStyleWhite14px600w),
                  Text("Payment status", style: textStyleWhite14px500w),
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
  void onInvoiceNumberSaved() {
    _invoiceNumberGenerated = true;
    setState(() {});
  }

  @override
  void onPaymentAcknowledged() {
    Utility.showSuccessToastB(context, "Payment Acknowledged");
    Navigator.pop(context);
  }
}
// '"Eligible to Raise Invoice"
// and "Invoice Approved"
// values are swapped in app when  selected in SFDC

/*


  // 9.9% received
  // Eligible to raise Invoice
  // Invoice Approved
  // Payment Released
  String getInvoiceProgress() {
    switch (response?.status) {
      case "9.9% received":
        return Images.kImagePD1;
      case "Eligible to raise Invoice":
        return Images.kImagePD2;
      case "Invoice Approved":
        return Images.kImagePD3;
      case "Payment Released":
        return Images.kImagePD4;
      default:
        return Images.kImagePD1;
        break;
    }
  }

*/
