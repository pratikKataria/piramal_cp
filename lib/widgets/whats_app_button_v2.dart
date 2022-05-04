import 'dart:io';

import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButtonV2 extends StatelessWidget {
  final String link;

  const WhatsAppButtonV2(this.link, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openWhatsapp(context);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorPrimaryLight,
        ),
        child: Image.asset(Images.kIconWhatsApp),
      ),
    );
  }

  openWhatsapp(BuildContext context) async {
    String whatsapp = link ?? "Hi";
    var whatsappURl_android = "http://api.whatsapp.com/send?text=$whatsapp";
    var whatappURL_ios = "https://api.whatsapp.com/send?text=${Uri.parse(whatsapp)}";

    // if (link == null) {
    //   Utility.showErrorToastB(context, "Mobile number not found");
    //   return;
    // }

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        Utility.showErrorToastB(context, "Whatsapp not installed");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        Utility.showErrorToastB(context, "Failed to open Whatsapp");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}

// if (Platform.isAndroid) {
//   // add the [https]
//   return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
// } else {
//   // add the [https]
//   return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
// }
