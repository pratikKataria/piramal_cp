import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/current_promo_presenter.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/current_promo_view.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/model/current_promo_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentPromotionScreen extends StatefulWidget {
  const CurrentPromotionScreen({Key key}) : super(key: key);

  @override
  _CurrentPromotionScreenState createState() => _CurrentPromotionScreenState();
}

class _CurrentPromotionScreenState extends State<CurrentPromotionScreen> implements CurrentPromoView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  CurrentPromoPresenter promoPresenter;
  List<CurrentPromoResponse> listOfPromos = [];

  @override
  void initState() {
    super.initState();
    promoPresenter = CurrentPromoPresenter(this);
    promoPresenter.getProjectList(context);
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
            Text("Current Promotions (${listOfPromos.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: ListView(
                children: listOfPromos.map<Widget>((e) => cardViewPromo(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewPromo(CurrentPromoResponse currentPromoData) {
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
          Container(
            height: 130.0,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Images.kImgEventPlaceholder1),
              fit: BoxFit.fill,
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text("${currentPromoData.name}", style: textStyle24px500w)),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorPrimaryLight,
                            ),
                            child: Image.asset(Images.kIconWhatsApp),
                          ),
                        ),
                        horizontalSpace(8.0),
                        InkWell(
                          onTap: () {
                            launch("tel://${currentPromoData?.mobilenumber ?? ""}");
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorPrimary,
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Image.asset(Images.kIconPhone, color: AppColors.white),
                          ),
                        ),
                        horizontalSpace(8.0),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorPrimary,
                          ),
                          child: Icon(
                            Icons.download_rounded,
                            color: AppColors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(10.0),
                Text("${currentPromoData.location}", style: textStyleSubText14px500w),
                verticalSpace(10.0),
                Text(
                  "${currentPromoData.shortDescription}",
                  style: textStyle14px500w,
                )
              ],
            ),
          ),
          verticalSpace(10.0),
        ],
      ),
    );
  }

  void openWhatsapp(String mobileNumber) async {
    var whatsapp = "+91${mobileNumber?? ""}";
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

  @override
  void onCurrentPromoListFetched(List<CurrentPromoResponse> projectListResponse) {
    listOfPromos.clear();
    listOfPromos.addAll(projectListResponse);
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
