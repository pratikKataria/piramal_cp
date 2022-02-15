import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/lead/lead_presenter.dart';
import 'package:piramal_channel_partner/ui/lead/lead_view.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({Key key}) : super(key: key);

  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> implements LeadView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  LeadPresenter leadPresenter;
  List<AllLeadResponse> listOfList = [];

  @override
  void initState() {
    super.initState();
    leadPresenter = LeadPresenter(this);
    leadPresenter.getLeadList(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Leads", style: textStyle24px500w),
                PmlButton(
                  height: 28.0,
                  text: "Add Lead",
                  color: AppColors.colorSecondary,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  onTap: () async {
                    var created = await Navigator.pushNamed(context, Screens.kAddLeadScreen);
                    if (created is bool && created) leadPresenter.getLeadListS(context);
                  },
                )
              ],
            ),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  leadPresenter.getLeadList(context);
                },
                children: listOfList.map<Widget>((e) => cardViewLead(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewLead(AllLeadResponse leadData) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
          Row(
            children: [
              /*      ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Container(
                  height: 46,
                  width: 46,
                  child: Image.asset(Images.kImgPlaceholder, fit: BoxFit.fill),
                ),
              ),
              horizontalSpace(14.0),*/
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${leadData.name}",
                      style: textStyle20px500w,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("${leadData.mobileNumber}", style: textStyleSubText14px500w),
                  ],
                ),
              ),
              Spacer(),
              PmlButton(
                height: 32.0,
                width: 32.0,
                color: AppColors.screenBackgroundColor,
                child: Icon(Icons.edit, size: 16),
                onTap: () async {
                  var created = await Navigator.pushNamed(context, Screens.kEditLeadScreen, arguments: leadData);
                  if (created is bool && created) leadPresenter.getLeadListS(context);
                },
              ),
              horizontalSpace(10.0),
              PmlButton(
                height: 32.0,
                width: 32.0,
                color: AppColors.colorPrimaryLight,
                child: Icon(Icons.delete, color: AppColors.colorPrimary, size: 16),
                onTap: () => leadPresenter.deleteLead(context, leadData),
              ),
            ],
          ),
          line(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.chipColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Text("${leadData.projectInterested}", style: textStyle14px500w),
          ),
          /* Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                horizontalSpace(10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.chipColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text("Piramal Mahalaxmi", style: textStyle14px500w),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  void onAllLeadFetched(List<AllLeadResponse> leadList) {
    listOfList.clear();
    listOfList.addAll(leadList);
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onLeadDeleted(AllLeadResponse response) {
    listOfList.remove(response);
    setState(() {});
  }
}
