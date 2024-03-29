import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingCardWidget extends StatelessWidget {
  final BookingResponse _bookingResponse;
  final HomePresenter _presenter;

  const BookingCardWidget(this._bookingResponse, this._presenter, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      margin: EdgeInsets.only(bottom: 18.0, left: 20.0, right: 20.0),
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
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Screens.kCustomerProfileDetailBooking, arguments: _bookingResponse);
              BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
              baseProvider.setBottomNavScreen(Screens.kCustomerProfileDetailBooking);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*       ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: Container(
                    height: 37,
                    width: 37,
                    child: Image.asset(Images.kImgPlaceholder, fit: BoxFit.fill),
                  ),
                ),
                horizontalSpace(8.0),*/
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${_bookingResponse?.name ?? ""}", style: textStyleRegular18pxW500),
                    // Text("Next Follow up: ${Utility.formatDate(_bookingResponse.nextFollowUp)}", style: textStyleSubText14px500w),
                  ],
                ),
                if (_bookingResponse.CRMApproved)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      color: AppColors.green,
                    ),
                    child: Text(
                      "Approved",
                      style: textStyleWhite10px500w,
                    ),
                  ) /*Image.asset(Images.kIconApproved, height: 34.0)*/
              ],
            ),
          ),
          Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Container(
                //   decoration:
                //       BoxDecoration(borderRadius: BorderRadius.circular(6), color: getRatingColor(_bookingResponse.newRating)),
                //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                //   child: Text("${_bookingResponse.newRating}", style: textStyleWhite14px500w),
                // ),
                // horizontalSpace(10.0),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(6),
                //     color: AppColors.chipColor,
                //   ),
                //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                //   child: Text("Validity: ${_bookingResponse.createdDays} Day", style: textStyle14px500w),
                // ),
                if (_bookingResponse.revisit) ...[
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
                  child: Text("${_bookingResponse?.projectFinalized ?? ""}", style: textStyle14px500w),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // calenderButton(context),
              // horizontalSpace(8.0),
              callButton(),
              horizontalSpace(8.0),
              WhatsAppButton(_bookingResponse?.mobilenumber),
              Spacer(),
              InkWell(
                onTap: () {
                  _presenter.getCustomerUnitDetail(context, _bookingResponse.sfdcid);
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
        ],
      ),
    );
  }

  Color getRatingColor(String rating) {
    switch (rating?.toUpperCase()) {
      case "HOT":
        return AppColors.colorPrimary;
      case "WARM":
        return AppColors.colorPrimaryLight;
      case "COLD":
        return AppColors.colorCOLD;
      default:
        return AppColors.colorPrimary;
    }
  }

  InkWell calenderButton(BuildContext context) {
    return InkWell(
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
    );
  }

  InkWell addButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorSecondary,
        ),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  InkWell callButton() {
    return InkWell(
      onTap: () {
        launch("tel://${_bookingResponse?.mobilenumber ?? ""}");
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
    );
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
    ).toLocal();

    if (picked != null) {
      _presenter.scheduleTime(context, "", _bookingResponse.sfdcid, x);
    }
  }
}
