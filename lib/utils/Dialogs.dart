import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Utility.dart';

class Dialogs {
  static ProgressDialog pd;

  static ProgressDialog _dialog;

  static void showLoader(BuildContext context, String description) {
    // print(context.toString() + 'nameeeeeeeeeeee');
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
                child: Text('$description', style: textStylePrimary14px500w, overflow: TextOverflow.ellipsis),
              ),
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

  static Future<Object> hideLoader(BuildContext context) async {
    // Navigator.pop(context);

    await Future.delayed(Duration(milliseconds: 300));

    if (_dialog != null) {
      _dialog.hide().then((value) {
        if (_dialog.isShowing()) {
          _dialog.hide();
        }
      });
    }

    await Future.delayed(Duration(milliseconds: 300));
    return Future(() => true);
  }

  static bool isDialogVisible() => _dialog.isShowing();

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
