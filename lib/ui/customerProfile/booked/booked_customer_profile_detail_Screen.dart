import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class BookedCustomerProfileDetailScreen extends StatelessWidget {
  const BookedCustomerProfileDetailScreen({Key key}) : super(key: key);

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
                        color: AppColors.attendButtonColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text("Booked", style: textStyleWhite14px500w),
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
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.colorSecondary,
                    ),
                    child: Icon(Icons.add, color: AppColors.white, size: 16.0,),
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
}
