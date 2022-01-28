import 'dart:developer' as dev;

import 'package:flutter/foundation.dart' show kIsWeb ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';

/// Created by Pratik Kataria on 20-02-2021.

class Utility {

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
  }


  static final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static double screenWidth(BuildContext context) {
    // print('${MediaQuery.of(context).size.width/1.55}');
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  static bool isWeb(BuildContext context) {
      return kIsWeb;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  static var paddingSize15Box = SizedBox(
    height: 15,
  );
  static var paddingSize10Box = SizedBox(
    height: 10,
  );

  static var paddingSize30Box = SizedBox(
    height: 30,
  );

  static log(var tag, var message) {
    dev.log('\n\n*****************\n$tag\n$message\n*****************\n\n');
    // print('\n\n*****************\n$tag\n$message\n*****************\n\n');
  }

  static void showErrorToast(BuildContext context, String text) async {
    FToast fToast = FToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0),
          color: AppColors.colorPrimary),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_rounded, color: AppColors.red),
          SizedBox(width: 6.0),
          Expanded(
              child:
              Text("$text", style: textStyleRed12px600w,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void showErrorToastC(BuildContext context, String text) async {
    FToast fToast = FToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.red),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_rounded, color: AppColors.white),
          SizedBox(width: 6.0),
          Expanded(
              child:
              Text("$text", style: textStyleWhite14px500w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 3),
    );
  }

  static void showErrorToastT(BuildContext context, String text) async {
    FToast fToast = FToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.red),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_rounded, color: AppColors.white),
          SizedBox(width: 6.0),
          Expanded(
              child:
              Text("$text", style: textStyleWhite14px500w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 3),
    );
  }

  static void showErrorToastB(BuildContext context, String text) async {
    FToast fToast = FToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.red),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_rounded, color: AppColors.white),
          SizedBox(width: 6.0),
          Expanded(
              child:
              Text("$text", style: textStyleWhite14px500w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  static void showSuccessToastB(BuildContext context, String text) async {
    FToast fToast = FToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Colors.green[900]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: AppColors.white),
          SizedBox(width: 6.0),
          Expanded(
              child:
              Text("$text", style: textStyleWhite12px600w,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }

  static void showToast(BuildContext context, String text) async {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  static void showToastB(BuildContext context, String text) async {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        fontSize: 16.0);
  }

/*  static Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + kRecordingFileName;
  }

  static Future<bool> checkPermission() async {
    Map<PermissionGroup, PermissionStatus> map = await new PermissionHandler()
        .requestPermissions(
            [PermissionGroup.storage, PermissionGroup.microphone]);
    print(map[PermissionGroup.microphone]);
    return map[PermissionGroup.microphone] == PermissionStatus.granted;
  }

  static Future pickImage() async {
    File _imageFile;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }
    return _imageFile;
  }*/

  static void portrait() =>
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  static void statusBarAndNavigationBarColor() =>
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white, // status bar color
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.background, // status bar icon color
      ));

  static void statusBarAndNavigationBarColorDark() =>
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.textColorBlack, // status bar color
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors
            .textColorBlack, // status bar icon color
      ));

/*  static String formatDate(String date) {
    //format: yyyy-MM-dd'T'HH:mm:ss.SSSZ
    if (date == null) return "";
    DateTime dt = DateTime.parse('2021-04-01T05:44:45.838Z');
    String dtm = DateFromat("MMM dd, yyyy").format(dt);
    return dtm;
  }*/

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    print('pratik 234 ${Duration(
        hours: hours, minutes: minutes, microseconds: micros).toString()}');
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static String calculateReturnDateString(String deliveryDate,
      int timePeriodDays) {
    DateTime deliveryDateTime = DateTime.parse(deliveryDate);
    DateTime returnTime = DateTime(
        deliveryDateTime.year, deliveryDateTime.month,
        deliveryDateTime.day + 7);
    return '${returnTime.day}/${returnTime.month}/${returnTime.year}';
  }

  static DateTime calculateReturnDate(String deliveryDate, int timePeriodDays) {
    DateTime deliveryDateTime = DateTime.parse(deliveryDate);
    DateTime returnTime = DateTime(
        deliveryDateTime.year, deliveryDateTime.month,
        deliveryDateTime.day + 7);
    return returnTime;
  }

  static int calculateExtendDays(String deliveryDate, int timePeriodDays) {
    DateTime deliveryDateTime = DateTime.parse(deliveryDate);
    DateTime returnDate = calculateReturnDate(deliveryDate, timePeriodDays);
    int days = deliveryDateTime
        .difference(returnDate)
        .inDays;
    return days;
  }

  static calculateTimePercentage(String endTime, String totalTime) {
    Duration end = parseDuration(endTime);
    Duration total = parseDuration(totalTime);

    int endMinutes = end.inMilliseconds;
    int totalMinutes = total.inMilliseconds;

    print('End minutes = $endMinutes && Total minutes = $totalMinutes');

    double percentageMinutes = (endMinutes / totalMinutes);
    print('Total Percentage Minutes = $percentageMinutes ');
    return percentageMinutes;
  }

  static Container separatedText(String lText, String rText,
      {TextStyle lStyle, TextStyle rStyle}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(lText, style: lStyle ?? textStyleSubText14px400w),
          Text(rText, style: rStyle ?? textStyleDarkRegular14px600w),
        ],
      ),
    );
  }

  static Future<Map<String, String>> header() async {
    return {'Authorization': await AuthUser.getInstance().token()};
  }
}

Widget verticalSpace(double height) =>
    SizedBox(
      height: height,
    );

Widget horizontalSpace(double height) =>
    SizedBox(
      width: height,
    );

Widget line({double width}) =>
    Container(
      width: width,
      height: 1,
      color: AppColors.lineColor,
    );

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}