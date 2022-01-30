import 'dart:io';

import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class WalkInCardWidget extends StatelessWidget {
  final BookingResponse _bookingResponse;

  const WalkInCardWidget(this._bookingResponse, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
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
              Navigator.pushNamed(context, Screens.kCustomerProfileDetailBooking);
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: Container(
                    height: 37,
                    width: 37,
                    child: Image.asset(Images.kImgPlaceholder, fit: BoxFit.fill),
                  ),
                ),
                horizontalSpace(8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${_bookingResponse?.name ?? ""}", style: textStyleRegular18pxW500),
                    Text("Next Follow up: March 27th", style: textStyleSubText14px500w),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.colorPrimary,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("Hot", style: textStyleWhite14px500w),
                ),
                horizontalSpace(10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.chipColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("Validity: 23 Day", style: textStyle14px500w),
                ),
                horizontalSpace(10.0),
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
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                padding: EdgeInsets.all(10.0),
                child: Image.asset(Images.kIconCalender),
              ),
              horizontalSpace(8.0),
              callButton(),
              horizontalSpace(8.0),
              whatsApp(),
              Spacer(),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorSecondary,
                ),
                child: Icon(Icons.add, color: AppColors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell whatsApp() {
    return InkWell(
      onTap: () {
        openWhatsapp();
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorPrimaryLight,
        ),
        child: Image.asset(Images.kIconWhatsApp),
      ),
    );
  }

  InkWell callButton() {
    return InkWell(
      onTap: () {
        launch("tel://${_bookingResponse?.mobilenumber ?? ""}");
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
    );
  }

  void openWhatsapp() async {
    var whatsapp = "+91${_bookingResponse?.mobilenumber??""}";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
