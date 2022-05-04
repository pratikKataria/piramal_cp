import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/core/core_presenter.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class UploadDocumentScreen extends StatefulWidget {
  final SignupRequest request;

  const UploadDocumentScreen(this.request, {Key key}) : super(key: key);

  @override
  _UploadDocumentScreenState createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> implements UploadDocumentView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  String reraFileName = "";
  String panCardFileName = "";
  String directorsFileName = "";
  String partnerShipFileName = "";
  String partnersFileName = "";
  String typeOfFirm = "";

  bool checkedValue = false;

  List<String> typeOfFirms = [];

  // DocumentUploadRequest documentUploadRequest = DocumentUploadRequest();
  CorePresenter presenter;

  @override
  void initState() {
    presenter = CorePresenter(this);
    presenter.getTypeOfFirm(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.kAppIcon, width: 100),
                  Text("Sign Up", style: textStyle20px500w),
                ],
              ),
              verticalSpace(20.0),
              buildProfileDetailCard("Type of Firm", "Partnership Firm"),
              buildProfileDetailCard2(
                "RERA Certificate",
                "$reraFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  widget.request.reraCertificatePDF = fileBytes;
                  reraFileName = name;
                  setState(() {});
                },
              ),
              buildProfileDetailCard2(
                "PAN Card",
                "$panCardFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  widget.request.panCard = fileBytes;
                  panCardFileName = name;
                  setState(() {});
                },
              ),
              buildProfileDetailCard2(
                "List of Directors",
                "$directorsFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  widget.request.lISTofDirectors = fileBytes;
                  directorsFileName = name;
                  setState(() {});
                },
              ),
              buildProfileDetailCard2(
                "Partnership Deed",
                "$partnerShipFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  widget.request.partnershipDeeds = fileBytes;
                  partnerShipFileName = name;
                  setState(() {});
                },
              ),
              buildProfileDetailCard2(
                "List of Partners",
                "$partnersFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  widget.request.listOfpartners = fileBytes;
                  partnersFileName = name;
                  setState(() {});
                },
              ),
              verticalSpace(15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                  ),
                  InkWell(
                    onTap: () {
                      presenter.getTermsAndCondition(context);
                    },
                    child: Stack(
                      children: [
                        Text("I Agree to the Terms & Conditions", style: textStyle14px500w),
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            height: 1,
                            color: AppColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              loginButton(context),
              verticalSpace(15.0),
            ],
          ),
        ),
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.screenBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("$mText", style: textStyle14px500w),
          Container(
            height: 35.0,
            decoration: BoxDecoration(
              color: AppColors.inputFieldBackgroundColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.only(right: 10.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select type of firm", style: subTextStyle),
              value: typeOfFirm,
              underline: Container(),
              items: <String>[...typeOfFirms].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: subTextStyle),
                );
              }).toList(),
              onChanged: (value) {
                typeOfFirm = value;
                widget?.request?.typeoffirm = typeOfFirm;
                // relationManagerListResponse = value;
                // signupRequest.relationshipManager = value;
                // signupRequest.typeoffirm = value.
                setState(() {});
              },
            ),
          ),
          // Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }

  Container buildProfileDetailCard2(String mText, String sText, Function onClick) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.screenBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$mText", style: textStyle14px500w),
              Text("$sText", style: textStyleSubText14px500w),
            ],
          ),
          InkWell(
            onTap: onClick,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorPrimary,
              ),
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                Images.kIconUpload,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PmlButton loginButton(BuildContext context) {
    return PmlButton(
      width: Utility.screenWidth(context) * 0.58,
      height: 36,
      text: "Next",
      onTap: () {
        if (!checkedValue) {
          onError("Please select terms and condition");
          return;
        }

        presenter.singUp(context, widget.request);

        // presenter.uploadDocument(context, documentUploadRequest);
        // var provider = Provider.of<BaseProvider>(context, listen: false);
        // provider.showToolTip();
        // Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }

  @override
  void onDocumentUploaded(DocumentUploadResponse documentUploadResponse) {
    Navigator.pop(context);
    Navigator.pushNamed(context, Screens.kHomeBase);

    var provider = Provider.of<BaseProvider>(context, listen: false);
    provider.showToolTip();
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onTokenGenerated(TokenResponse tokenResponse) {}

  @override
  void onTypeOfFirmFetched(List<String> brList) {
    typeOfFirms.clear();
    typeOfFirms.addAll(brList);
    typeOfFirm = typeOfFirms?.first ?? "";
    widget?.request?.typeoffirm = typeOfFirm;
    setState(() {});
  }

  @override
  void onSignupSuccessfully(SignupResponse signupResponse) async {
    LoginResponse loginResponse = LoginResponse();
    loginResponse.accountId = signupResponse.brokerAccountID;

    Dialogs.hideLoader(context);
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.userCredentials = loginResponse;
    AuthUser.getInstance().login(currentUser);

    Navigator.pop(context); // login
    Navigator.pop(context); // signup
    Navigator.pop(context); // upload
    Navigator.pushNamed(context, Screens.kHomeBase);

    var provider = Provider.of<BaseProvider>(context, listen: false);
    provider.showToolTip();
  }

  @override
  void onTermsAndConditionFetched(TermsAndConditionResponse termsAndConditionResponse) {
    showDetailDialog(context, termsAndConditionResponse?.termsAndCondition);
  }

  void showDetailDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white,
      content: Column(
        children: [
          verticalSpace(20.0),
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
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Text("$message"),
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
