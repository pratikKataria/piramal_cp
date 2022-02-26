import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/core/core_presenter.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/ui/myProfile/model/my_profile_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class UploadPendingDocumentScreen extends StatefulWidget {
  final MyProfileResponse assistResponse;
  const UploadPendingDocumentScreen(this.assistResponse, {Key key}) : super(key: key);

  @override
  _UploadPendingDocumentScreenState createState() => _UploadPendingDocumentScreenState();
}

class _UploadPendingDocumentScreenState extends State<UploadPendingDocumentScreen> implements UploadDocumentView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  String reraFileName = "";
  String panCardFileName = "";
  String directorsFileName = "";
  String partnerShipFileName = "";
  String partnersFileName = "";
  String typeOfFirm = "";

  List<String> typeOfFirms = [];

  DocumentUploadRequest documentUploadRequest = DocumentUploadRequest();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.0),
              Text("Upload Pending Document", style: textStyle20px500w),
              verticalSpace(20.0),
              // buildProfileDetailCard("Type of Firm", "Partnership Firm"),
             if (!widget.assistResponse.reraCertificatePDFUPLOADED) buildProfileDetailCard2(
                "RERA Certificate",
                "$reraFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  documentUploadRequest.reraCertificatePDF = fileBytes;
                  reraFileName = name;
                  setState(() {});
                },
              ),
              if (!widget.assistResponse.panCardPDFUPLOADED) buildProfileDetailCard2(
                "PAN Card",
                "$panCardFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  documentUploadRequest.PanCard = fileBytes;
                  panCardFileName = name;
                  setState(() {});
                },
              ),
              if (!widget.assistResponse.lISTofDirectorsPDFUPLOADED)  buildProfileDetailCard2(
                "List of Directors",
                "$directorsFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  documentUploadRequest.lISTofDirectors = fileBytes;
                  directorsFileName = name;
                  setState(() {});
                },
              ),
              if (!widget.assistResponse.partnershipDeedsPDFUPLOADED)  buildProfileDetailCard2(
                "Partnership Deed",
                "$partnerShipFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  documentUploadRequest.partnershipDeeds = fileBytes;
                  partnerShipFileName = name;
                  setState(() {});
                },
              ),
              if (!widget.assistResponse.listOfpartnersPDFUPLOADED)  buildProfileDetailCard2(
                "List of Partners",
                "$partnersFileName",
                () async {
                  List<String> file = await Utility.pickFile(context);
                  String fileBytes = file[0];
                  String name = file[1];
                  documentUploadRequest.listOfpartners = fileBytes;
                  partnersFileName = name;
                  setState(() {});
                },
              ),
              verticalSpace(15.0),
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
                // widget?.request?.typeoffirm = typeOfFirm;
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

  Center loginButton(BuildContext context) {
    return Center(
      child: PmlButton(
        width: Utility.screenWidth(context) * 0.58,
        height: 36,
        text: "Next",
        onTap: () {
          // presenter.singUp(context, widget.request);

          presenter.uploadDocument(context, documentUploadRequest);
          // var provider = Provider.of<BaseProvider>(context, listen: false);
          // provider.showToolTip();
          // Navigator.pushNamed(context, Screens.kHomeBase);
        },
      ),
    );
  }

  @override
  void onDocumentUploaded(DocumentUploadResponse documentUploadResponse) {
    Utility.showSuccessToastB(context, "Document Uploaded Successfully");
    Navigator.pop(context, true);
    // Navigator.pushNamed(context, Screens.kHomeBase);
    //
    // var provider = Provider.of<BaseProvider>(context, listen: false);
    // provider.showToolTip();
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
    // widget?.request?.typeoffirm = typeOfFirm;
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
    //ignore
  }
}
