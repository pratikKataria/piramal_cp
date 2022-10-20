import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/base/LwcView.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/base/model/LwcDownloadResponse.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class DownloadButtonLwc extends StatelessWidget implements LwcView {
  final String projectId;
  final String fileIdentifier;
  Function callBackFunction;
  BuildContext context;

  BasePresenter presenter;

  DownloadButtonLwc(this.projectId, this.fileIdentifier, {Function onActionComplete, Key key}) : super(key: key) {
    callBackFunction = onActionComplete;
    presenter = BasePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    if (this.context == null) this.context = context;
    return InkWell(
      onTap: () {
        presenter.openFileUsingLWC(context, projectId);
      },
      child: Container(
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
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  onLwcLinkFetched(LwcDownloadResponse response) {
    Utility.launchUrlX(context, response.brochureDownloadLink);
  }
}

/* if (projectDownloadLinkReponse?.downloadlink == null || (projectDownloadLinkReponse?.downloadlink?.isEmpty ?? true)) {
            Utility.showErrorToastB(context, "No Link!");
            return;
          }
*/
