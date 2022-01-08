import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Utility.dart';

class Dialogs {
  static ProgressDialog pd;

  static void ackAlert(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fonn'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                /*  Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, Constants.OTPSCREEN);*/
              },
            ),
          ],
        );
      },
    );
  }

  static ProgressDialog _dialog;

  static void showLoader(BuildContext context, String description, String title) {
    print(context.toString() + 'nameeeeeeeeeeee');
    _dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        customBody: Container(
          height: 65.0,
          child: Row(
            children: [
              horizontalSpace(20.0),
              Container(width: 24.0, height: 24.0, child: CircularProgressIndicator()),
              horizontalSpace(20.0),
              Expanded(
                  child:
                      Text('$description', style: textStylePrimary14px500w, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ));
    _dialog.show();

    // Future.delayed(Duration(seconds: 7), () {
    //   if (_dialog.isShowing()) {
    //     _dialog.hide();
    //   }
    // });
  }

  static void hideLoader(BuildContext context) {
    // Navigator.pop(context);
    if (_dialog != null)
      _dialog.hide().then((value) {
        print("Hide Loader $value");
        print("Hide Loader ${_dialog.isShowing()}");
        if (_dialog.isShowing()) {
          _dialog.hide();
        }
      });
  }

  static void showProgressDialod(BuildContext context) {
    if (pd == null) {
      pd = new ProgressDialog(context, type: ProgressDialogType.Normal);
    }
    pd.style(message: "Loading..");
    pd.show();
  }

  static void hideProgressDialog(BuildContext context) {
    // if (pd != null) {
    //   pd.hide().whenComplete(() => {print("hide completed")});
    // }
    Navigator.pop(context);
  }

  static Widget buildProgressIndicator(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }

  static Future<bool> exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Do you want to exit this application?'),
              content: new Text('Press Yes to leave...'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => exit(0),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  static void showNonMendetoryUpdate(BuildContext context, String message, ClickInterface interface) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fonn'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () {
                Navigator.pop(context);
//                StoreRedirect.redirect();
//                 StoreRedirect.redirect(
//                     androidAppId: "com.fonn.fonnapp", iOSAppId: "1513700647");
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                interface.onClick();
              },
            ),
          ],
        );
      },
    );
  }

  static void showMendetoryUpdate(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Revisor'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () {
                Navigator.pop(context);
                // StoreRedirect.redirect(androidAppId: "com.moreyeahs.revisor.revisor", iOSAppId: "15");
              },
            ),
          ],
        );
      },
    );
  }

  static void showLoginExpireDialog(BuildContext context, String message, Function interface) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Image.asset(Images.kIconExpireToken, height: 50.0),
                      verticalSpace(10.0),
                      Text('Login session expired', style: textStyleDark14px500w),
                      verticalSpace(10.0),
                      // RevButton(
                      //   padding: EdgeInsets.all(12.0),
                      //   child: Text('Update Session', style: textStyleDark14px500w),
                      //   onTap: () async {
                      //     await AuthUser.getInstance().logout();
                      //     Navigator.pop(context); // pop dialog
                      //     Navigator.popAndPushNamed(context, Screens.kLoginScreen); // pop dialog
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showCustomDialog(BuildContext context,
      {Function onAccept, Function onReject, String title, String message}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "No",
        style: textStyleDark16px600w,
      ),
      onPressed: onReject ?? () => Navigator.pop(context),
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Yes",
        style: textStyleDark16px600w,
      ),
      onPressed: onAccept,
    );
/*
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$title"),
      content: Text("$message"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
*/

    // set up the AlertDialog
    Scaffold body = Scaffold(
      backgroundColor: AppColors.background.withOpacity(0.1),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          height: Utility.screenHeight(context) * .20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('$title', style: textStyleRegular16px700w),
              Text('$message', style: textStyle12px500w),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.0,
                      margin: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          width: 1,
                          color: AppColors.textColor,
                        ),
                      ),
                      child: cancelButton,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      margin: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: continueButton,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 2.0,
            sigmaX: 2.0,
          ),
          child: body,
        );
      },
    );
  }
}

abstract class ClickInterface {
  void onClick();
}

/*
AlertDialog(
backgroundColor: AppColors.colorPrimary,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.all(Radius.circular(10))),
contentPadding: EdgeInsets.all(0),
titlePadding: EdgeInsets.all(0),
title: Container(
width: Utility.screenWidth(context),
height: 50,
decoration: BoxDecoration(
borderRadius: BorderRadius.only(
topLeft: Radius.circular(10), topRight: Radius.circular(10)),
color: AppColors.colorPrimary,
),
alignment: Alignment.center,
child: Text(title,
style: TextStyle(
color: AppColors.white,
fontFamily: kFontFamily,
fontWeight: FontWeight.bold,
fontSize: 18)),
),
content: Stack(
children: <Widget>[
Container(
color: AppColors.white,
margin: EdgeInsets.only(bottom: 50),
child: SingleChildScrollView(
child: Container(
width: Utility.screenWidth(context),
padding: EdgeInsets.all(10),
),
),
),
Positioned(
bottom: 0,
left: 0,
right: 0,
child: InkWell(
child: Container(
width: Utility.screenWidth(context),
height: 50,
decoration: BoxDecoration(
borderRadius: BorderRadius.only(
bottomLeft: Radius.circular(10),
bottomRight: Radius.circular(10)),
color: AppColors.colorPrimary,
),
alignment: Alignment.center,
child: Text(
"Close",
style: TextStyle(
color: AppColors.white,
fontFamily: kFontFamily,
fontWeight: FontWeight.bold,
fontSize: 18),
),
),
onTap: () {
Navigator.pop(context);
listener.onClick();
},
),
),
],
),
)*/
