import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class DownloadButton extends StatelessWidget {
  final String link;

  const DownloadButton(this.link, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Utility.launchUrlX(context, link);
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
}
