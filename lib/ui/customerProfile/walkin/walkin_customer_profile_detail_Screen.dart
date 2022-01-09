import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/customerProfile/widget/left_chat_widget.dart';
import 'package:piramal_channel_partner/ui/customerProfile/widget/right_chat_widget.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class WalkinCustomerProfileDetailScreen extends StatelessWidget {
  const WalkinCustomerProfileDetailScreen({Key key}) : super(key: key);

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
                  Text("Narayana Patel", style: textStyleRegular18pxW500),
                  Text("Next Follow up: March 27th", style: textStyleSubText14px500w),
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
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                padding: EdgeInsets.all(10.0),
                child: Image.asset(Images.kIconPhone),
              ),
              horizontalSpace(8.0),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                child: Image.asset(Images.kIconWhatsApp),
              ),
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

          //Comment layout
          verticalSpace(25.0),
          line(),
          verticalSpace(10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Visit No. 1", style: textStyle20px500w),
              horizontalSpace(12.0),
              Text("March 11th, 2021 / 11:41 AM", style: textStyleSubText14px500w),
            ],
          ),

         //Chat
          verticalSpace(20.0),
          LeftChatWidget(name: "Hariom Anand(CM)", chatText: "Client has to get his eligibility checked",),

          verticalSpace(10.0),
          LeftChatWidget(name: "Maryam Kapur (SM)", chatText: "Yes, client mentioned kiya tha",),

          verticalSpace(10.0),
          Align(alignment: Alignment.centerRight, child: RightChatWidget()),


          //Second visit
          verticalSpace(25.0),
          line(),
          verticalSpace(10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Visit No. 2", style: textStyle20px500w),
              horizontalSpace(12.0),
              Text("March 18th, 2021 / 2:11 AM", style: textStyleSubText14px500w),
            ],
          ),

          //Chat
          verticalSpace(20.0),
          LeftChatWidget(name: "Hariom Anand(CM)", chatText: "Client has to get his eligibility checked",),

          verticalSpace(10.0),
          LeftChatWidget(name: "Maryam Kapur (SM)", chatText: "Yes, client mentioned kiya tha",),

          verticalSpace(10.0),
          Align(alignment: Alignment.centerRight, child: RightChatWidget()),
        ],
      ),
    );
  }
}