import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/core/core_presenter.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({Key key}) : super(key: key);

  @override
  _UploadDocumentScreenState createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> implements UploadDocumentView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  bool checkedValue = false;

  String reraFileName = "";
  String panCardFileName = "";
  String directorsFileName = "";
  String partnerShipFileName = "";
  String partnersFileName = "";

  DocumentUploadRequest documentUploadRequest = DocumentUploadRequest();
  CorePresenter presenter;

  @override
  void initState() {
    presenter = CorePresenter(this);
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
                  documentUploadRequest.reraCertificatePDF = fileBytes;
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
                  documentUploadRequest.PanCard = fileBytes;
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
                  documentUploadRequest.lISTofDirectors = fileBytes;
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
                  documentUploadRequest.partnershipDeeds = fileBytes;
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
                  documentUploadRequest.listOfpartners = fileBytes;
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
                  Text("I Agree to the Terms & Conditions", style: textStyle14px500w),
                ],
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
          Text(
            "$mText",
            style: textStyle14px500w,
          ),
          Text("$sText", style: textStyleSubText14px500w),
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
        if (checkedValue) {
          presenter.uploadDocument(context, documentUploadRequest);
          return;
        }

        onError("Please accept Terms & Conditions");

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
  void onTokenGenerated(TokenResponse tokenResponse) {

  }
}
