import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/upload/upload_presenter.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/upload/upload_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

import '../../../res/Images.dart';
import 'model/upload_file_response.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> implements UploadView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  String note = "";
  String file = "";
  String fileExt = "";
  String fileName = "";

  UploadPresenter presenter;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter = UploadPresenter(this);
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
            Text("Upload", style: textStyle24px500w),
            verticalSpace(22.0),
            buildProfileDetailCard("Add Note", "Enter note "),
            buildProfileDetailCard2("Attach File"),
            verticalSpace(22.0),
            Center(
              child: PmlButton(
                width: Utility.screenWidth(context) * 0.55,
                text: "Submit",
                onTap: () {
                  FocusScope.of(context).unfocus();
                  presenter.uploadNoteAndAttachments(context, note, fileName, fileExt, file);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildProfileDetailCard2(String mText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 12.0, right: 10.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$mText", style: textStyle14px500w),
              Container(
                width: 150.0,
                child: Text(
                  this.fileName ?? "",
                  style: textStyleSubText14px500w,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              List<String> file = await Utility.pickFile2(context);
              this.file = file[0];
              this.fileName = file[1];
              this.fileExt = file[2];

              setState(() {});
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorPrimary,
              ),
              padding: EdgeInsets.all(8.0),
              child: Image.asset(Images.kIconUpload),
            ),
          ),
        ],
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("$mText", style: textStyle14px500w),
          TextFormField(
            // obscureText: true,
            textAlign: TextAlign.left,
            // controller: otpTextController,
            maxLines: 1,
            // inputFormatters: [LengthLimitingTextInputFormatter(4)],
            textCapitalization: TextCapitalization.none,
            controller: textEditingController,
            style: subTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "$hint",
              hintStyle: subTextStyle,
              isDense: true,
              suffixStyle: TextStyle(color: AppColors.textColor),
            ),
            onChanged: (String val) {
              note = val;
            },
          ),
          // Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onFileUploaded(UploadFileResponse response) {
    Utility.showSuccessToastB(context, "Note and Attachment added successfully");
    note = "";
    file = "";
    fileExt = "";
    fileName = "";
    textEditingController.clear();
    setState(() {});
  }
}
