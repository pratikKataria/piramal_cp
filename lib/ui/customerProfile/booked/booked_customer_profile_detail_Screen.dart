import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/whats_app_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedCustomerProfileDetailScreen extends StatelessWidget {
  final BookingResponse response;

  BookedCustomerProfileDetailScreen(this.response, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              verticalSpace(20.0),
              //customer pic with name and time
              Row(
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
                      Text("${response?.name}", style: textStyleRegular18pxW500),
                      Text("Next Follow up: -", style: textStyleSubText14px500w),
                    ],
                  ),
                ],
              ),

              //calender call whatsapp
              verticalSpace(12.0),
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
                  InkWell(
                    onTap: () {
                      launch("tel://${response?.name ?? ""}");
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
                  WhatsAppButton("${response?.mobilenumber}"),
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
                        color: Utility.getRatingColor(response?.newRating),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("${response?.newRating}", style: textStyleWhite14px500w),
                    ),
                    horizontalSpace(10.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.chipColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("Validity: ${response?.createdDays} Days", style: textStyle14px500w),
                    ),
                    horizontalSpace(10.0),
                    if (response.revisit)
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
                      showDetailDialog(context);
                    },
                  ),
                ],
              ),
              verticalSpace(25.0),
              Container(
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
              Text("On March 21th, 2021", style: textStyleSubText14px500w),
            ],
          ),
        ),

        verticalSpace(30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Image.asset(Images.kIconProject),
        ),

        verticalSpace(30.0),
        line(),
      ],
    );
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

  void showDetailDialog(BuildContext context) {
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
                buildDialogRow("Unit Number", "1102"),
                buildDialogRow("Tower", "North Tower / Tower 3"),
                buildDialogRow("Carpet Area", "1152 Sq.Ft."),
                buildDialogRow("Agreement Value", "INR 3.2 Cr."),
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
}
