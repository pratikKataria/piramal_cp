import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ProjectDetailDownloadPage extends StatelessWidget {
  const ProjectDetailDownloadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          line(),
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconHome, color: AppColors.colorSecondary, width: 20.0),
              horizontalSpace(30.0),
              Text("Masterplan", style: textStyle20px500w),
              Spacer(),

              //whats app and download
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                child: Image.asset(Images.kIconWhatsApp),
              ),
              horizontalSpace(8.0),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimary,
                ),
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  Images.kIconDownload,
                ),
              ),
            ],
          ),

          verticalSpace(20.0),
          line(),
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconBrochure, width: 15.0),
              horizontalSpace(30.0),
              Text("Brochure", style: textStyle20px500w),
              Spacer(),

              //whats app and download
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                child: Image.asset(Images.kIconWhatsApp),
              ),
              horizontalSpace(8.0),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimary,
                ),
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  Images.kIconDownload,
                ),
              ),
            ],
          ),

          verticalSpace(20.0),
          line(),
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconPlan, width: 15.0),
              horizontalSpace(30.0),
              Text("North Tower\nTypical Floor Plan", style: textStyle14px500w),
              Spacer(),

              //whats app and download
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                child: Image.asset(Images.kIconWhatsApp),
              ),
              horizontalSpace(8.0),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimary,
                ),
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  Images.kIconDownload,
                ),
              ),
            ],
          ),

          verticalSpace(20.0),
          line(),
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconPlan, width: 15.0),
              horizontalSpace(30.0),
              Text("Central Tower\nTypical Floor Plan", style: textStyle14px500w),
              Spacer(),

              //whats app and download
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight,
                ),
                child: Image.asset(Images.kIconWhatsApp),
              ),
              horizontalSpace(8.0),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimary,
                ),
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  Images.kIconDownload,
                ),
              ),
            ],
          ),
          verticalSpace(20.0),
          line(),
        ],
      ),
    );
  }
}
