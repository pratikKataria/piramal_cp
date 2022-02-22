import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/myProfile/model/my_profile_response.dart';
import 'package:piramal_channel_partner/ui/myProfile/my_profile_presenter.dart';
import 'package:piramal_channel_partner/ui/myProfile/my_profile_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> implements MyProfileView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  MyProfilePresenter leadPresenter;
  MyProfileResponse assistResponse;

  @override
  void initState() {
    super.initState();
    leadPresenter = MyProfilePresenter(this);
    leadPresenter.getProfileData(context);
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.18;
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: RefreshListView(
          onRefresh: () {
            leadPresenter.getProfileData(context);
          },
          children: [
            verticalSpace(22.0),
            Text("My Profile", style: textStyle24px500w),
            verticalSpace(33.0),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    String img = await Utility.pickImg(context);
                    leadPresenter.uploadProfile(context, img);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Container(
                      height: 46,
                      width: 46,
                      child: Image.memory(Utility.convertMemoryImage(assistResponse?.profilepic)),
                    ),
                  ),
                ),
                horizontalSpace(14.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(assistResponse?.name ?? "", style: textStyle20px500w),
                    Text("RERA ID ${assistResponse?.reraID ?? ""}", style: textStyleSubText14px500w),
                  ],
                ),
                Spacer(),
                PmlButton(
                  height: 32.0,
                  width: 32.0,
                  child: Icon(Icons.edit, color: AppColors.white, size: 16),
                  onTap: () async {
                    bool allDocumentUploaded = assistResponse.listOfpartnersPDFUPLOADED &&
                        assistResponse.lISTofDirectorsPDFUPLOADED &&
                        assistResponse.panCardPDFUPLOADED &&
                        assistResponse.reraCertificatePDFUPLOADED &&
                        assistResponse.partnershipDeedsPDFUPLOADED;

                    if (allDocumentUploaded) {
                      Utility.showSuccessToastB(context, "All documents already uploaded");
                      return;
                    }

                    var hasUpdate =
                        await Navigator.pushNamed(context, Screens.kUploadPendingDocumentScreen, arguments: assistResponse);
                    if (hasUpdate is bool && hasUpdate) {
                      leadPresenter.getProfileDataS(context);
                    }
                  },
                )
              ],
            ),
            verticalSpace(30.0),
            buildProfileDetailCard("Primary Contact Person", assistResponse?.primaryContactPerson ?? ""),
            buildProfileDetailCard("Primary Mobile Number", assistResponse?.primaryMobileNo ?? ""),
            buildProfileDetailCard("Secondary Mobile Number", assistResponse?.secondaryMobileNo ?? ""),
            buildProfileDetailCard("Primary Email ID", assistResponse?.primaryEmail ?? ""),
            buildProfileDetailCard("Permanent Account Number (PAN)", assistResponse?.pan ?? ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Click on", style: textStyleSubText16px500w),
                horizontalSpace(6.0),
                PmlButton(
                  height: 24.0,
                  width: 24.0,
                  child: Icon(Icons.edit, color: AppColors.white, size: 12.0),
                ),
                horizontalSpace(6.0),
                Text("to upload pending documents", style: textStyleSubText16px500w),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$mText",
            style: textStyle14px500w,
          ),
          Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProfileDataFetch(MyProfileResponse myAssistResponse) {
    assistResponse = myAssistResponse;
    setState(() {});
  }

  @override
  void onProfileUploaded() {
    leadPresenter.getProfileDataS(context);
  }
}
