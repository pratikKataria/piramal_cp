import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/myAssit/model/my_assist_response.dart';
import 'package:piramal_channel_partner/ui/myAssit/my_assist_presenter.dart';
import 'package:piramal_channel_partner/ui/myAssit/my_assist_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAssistScreen extends StatefulWidget {
  const MyAssistScreen({Key key}) : super(key: key);

  @override
  _MyAssistScreenState createState() => _MyAssistScreenState();
}

class _MyAssistScreenState extends State<MyAssistScreen> implements MyAssistView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  MyAssistPresenter leadPresenter;
  MyAssistResponse assistResponse;

  @override
  void initState() {
    super.initState();
    leadPresenter = MyAssistPresenter(this);
    leadPresenter.getAssistData(context);
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
            Text("My Assist", style: textStyle24px500w),
            verticalSpace(33.0),
            if (assistResponse != null)
              Expanded(
                child: ListView(
                  children: [
                    cardViewAssist(
                      assistResponse?.relationshipManagerName,
                      assistResponse?.relationshipManagerLabel,
                      assistResponse?.relationshipManagerMobile,
                    ),
                    verticalSpace(24.0),
                    line(),
                    verticalSpace(24.0),
                    cardViewAssist(
                      assistResponse?.headOfDepartmentName,
                      assistResponse?.headOfDepartmentLabel,
                      assistResponse?.headOfDepartmentMobile,
                    ),
                  ],
                ),
              ),
            Center(
              child: PmlButton(
                width: Utility.screenWidth(context) * 0.55,
                text: "Raise Query",
              ),
            ),
            verticalSpace(50.0),
          ],
        ),
      ),
    );
  }

  cardViewAssist(String name, String profile, String number) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: Container(
            height: 46,
            width: 46,
            padding: EdgeInsets.all(10.0),
            color: AppColors.assistIconBackgroundColor,
            child: Image.asset(Images.kIconicAssistPerson),
          ),
        ),
        horizontalSpace(14.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$name", style: textStyle20px500w),
            Text("$profile", style: textStyleSubText14px500w),
          ],
        ),
        Spacer(),
        PmlButton(
          onTap: () {
            launch("tel://$number ?? " "}");
          },
          height: 32.0,
          width: 32.0,
          color: AppColors.colorPrimaryLight,
          padding: EdgeInsets.all(10.0),
          child: Image.asset(Images.kIconPhone),
        ),
        horizontalSpace(10.0),
        PmlButton(
          height: 32.0,
          width: 32.0,
          color: AppColors.colorPrimaryLight,
          child: Image.asset(Images.kIconWhatsApp),
        ),
      ],
    );
  }

  @override
  void onAssistDataFetched(MyAssistResponse myAssistResponse) {
    assistResponse = myAssistResponse;
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
