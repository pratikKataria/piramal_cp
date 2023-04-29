import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/RouteTransition.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/Strings.dart';
import 'package:piramal_channel_partner/ui/base/base_screen.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/bottom_navigation_base_screen.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_screen.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_screen.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_screen.dart';
import 'package:piramal_channel_partner/ui/cpEvent/cp_event_screen.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/current_promotions_screen.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/booked_customer_profile_detail_Screen.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/walkin_customer_profile_detail_Screen.dart';
import 'package:piramal_channel_partner/ui/lead/addLead/add_lead_screen.dart';
import 'package:piramal_channel_partner/ui/lead/editLead/edit_lead_screen.dart';
import 'package:piramal_channel_partner/ui/lead/lead_screen.dart';
import 'package:piramal_channel_partner/ui/myAssit/projectList/project_screen.dart';
import 'package:piramal_channel_partner/ui/myProfile/my_profile.dart';
import 'package:piramal_channel_partner/ui/myProfile/uploadPendingDocument/upload_pending_document_screen.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_screen.dart';
import 'package:piramal_channel_partner/ui/videoScreen/video_screen.dart';
import 'package:piramal_channel_partner/utils/scroll_behavior.dart';
import 'package:provider/provider.dart';

import 'ui/core/login/login_screen.dart';
import 'ui/myAssit/assist/my_assist_screen.dart';
import 'ui/projectsFlo/projectDetail/project_detail_screen.dart';
import 'user/AuthUser.dart';
import 'utils/Utility.dart';
import 'utils/navigator_gk.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'a', // id
    'High Importance Notifications', // title
    showBadge: true,
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;

  AndroidBitmap androidBitmap;
  BigPictureStyleInformation styleInformation;

  String error = "Error Message -> ";

  try {
    print("Message Received: ${message.data}");
    String image = /*message.data["image"]*/"https://images.unsplash.com/photo-1488372759477-a7f4aa078cb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
    // print(image);

    /* final Response response = await Dio().get(image, options: Options(responseType: ResponseType.bytes));
        Uint8List imageBase64 = response.data; //Uint8List
        androidBitmap = ByteArrayAndroidBitmap.fromBase64String(base64Encode(imageBase64));
        styleInformation = BigPictureStyleInformation(androidBitmap);*/

    final Response response = await Dio().get(image, options: Options(responseType: ResponseType.bytes));
    error = "$error ${response.statusCode} ${response.data} ";

    Uint8List imageBase64 = response.data; //Uint8List
    androidBitmap = ByteArrayAndroidBitmap.fromBase64String(base64Encode(imageBase64));
    styleInformation = BigPictureStyleInformation(androidBitmap);
  } catch (er) {
    error = "$error $er";
    print(er);
  }

  error = " $error ${notification.body}";

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      "400",
      "404",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          playSound: true,
          icon: '@mipmap/ic_launcher_foreground',
          largeIcon: androidBitmap,
          styleInformation: styleInformation,
        ),
      ),
    );
  }

  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Utility.statusBarAndNavigationBarColor();
  await Utility.portrait();

  // await Firebasep.initializeApp();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA9PpNpiNMkyI0nnxnjgboSHLji_2jqnqw",
            appId: "1:970701622319:ios:124e18c9d426b905030ada",
            messagingSenderId: "970701622319",
            projectId: "cp-mobile-app-a7646"));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  // AwesomeNotifications().initialize(
  //   // set the icon to null if you want to use the default app icon
  //     'resource://drawable/ic_app_logo',
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           ledColor: Colors.white)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [NotificationChannelGroup(channelGroupkey: 'basic_channel_group', channelGroupName: 'Basic group')],
  //     debug: true);
  //
  // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //   if (!isAllowed) {
  //     // This is just a basic example. For real apps, you must show some
  //     // friendly dialog box before call the request method.
  //     // This is very important to not harm the user experience
  //     AwesomeNotifications().requestPermissionToSendNotifications();
  //   }
  // });

  bool authResult = await (AuthUser.getInstance()).isLoggedIn();

  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp(authResult));
}

class MyApp extends StatelessWidget {
  final bool authResult;

  const MyApp(this.authResult, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterFirebaseNotification();

    return ChangeNotifierProvider<BaseProvider>(
      create: (_) => BaseProvider(authResult),
      child: MaterialApp(
        title: kAppName,
        theme: ThemeData(primarySwatch: Colors.deepOrange, scaffoldBackgroundColor: AppColors.white),
        navigatorKey: navigatorGk,
        builder: (_, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: BaseScreen(child: child),
          );
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case "/":
              return RouteTransition(widget: BottomNavigationBaseScreen());
              break;
            case Screens.kHomeBase:
              return RouteTransition(widget: BottomNavigationBaseScreen());
              break;
            case Screens.kCustomerProfileDetailWalkin:
              return RouteTransition(widget: WalkinCustomerProfileDetailScreen(settings.arguments));
              break;
            case Screens.kCustomerProfileDetailBooking:
              return RouteTransition(widget: BookedCustomerProfileDetailScreen(settings.arguments));
              break;
            case Screens.kProjectScreen:
              return RouteTransition(widget: ProjectScreen());
              break;
            case Screens.kCurrentPromotionsScreen:
              return RouteTransition(widget: CurrentPromotionScreen());
              break;
            case Screens.kLeadScreen:
              return RouteTransition(widget: LeadScreen());
              break;
            case Screens.kCPEventScreen:
              return RouteTransition(widget: CPEventScreen());
              break;
            case Screens.kMyAssistScreen:
              return RouteTransition(widget: MyAssistScreen(settings.arguments));
              break;
            case Screens.kMyAssistProjectScreen:
              return RouteTransition(widget: ProjectScreenMyAssist());
              break;
            case Screens.kSettingsScreen:
              return RouteTransition(widget: MyProfileScreen());
              break;
            case Screens.kAddLeadScreen:
              return RouteTransition(widget: AddLeadScreen());
              break;
            case Screens.kProjectDetailScreen:
              return RouteTransition(widget: ProjectDetailScreen(settings.arguments));
              break;
            case Screens.kLoginScreen:
              return RouteTransition(widget: LoginScreen());
              break;
            case Screens.kSignupScreen:
              return RouteTransition(widget: SignupScreen(settings.arguments));
              break;
            case Screens.kUploadDocumentScreen:
              return RouteTransition(widget: UploadDocumentScreen(settings.arguments));
              break;
            case Screens.kUploadPendingDocumentScreen:
              return RouteTransition(widget: UploadPendingDocumentScreen(settings.arguments));
              break;
            case Screens.kEditLeadScreen:
              return RouteTransition(widget: EditLeadScreen(settings.arguments));
              break;
            case Screens.kConstructionUpdate:
              return RouteTransition(widget: ConstructionUpdateScreen(settings.arguments));
              break;
            case Screens.kVideoScreen:
              return RouteTransition(widget: VideoScreen());
              break;
            default:
              return RouteTransition(widget: BottomNavigationBaseScreen());
              break;
          }
        },
        home: checkAuthUser(authResult),
      ),
    );
  }

  Future<void> RegisterFirebaseNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      AndroidBitmap androidBitmap;
      BigPictureStyleInformation styleInformation;

      String error = "Error Message -> ";

      try {
        print("Message Received: ${message.data}");
        String image = /*message.data["image"]*/"https://images.unsplash.com/photo-1488372759477-a7f4aa078cb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
        // print(image);

        /* final Response response = await Dio().get(image, options: Options(responseType: ResponseType.bytes));
        Uint8List imageBase64 = response.data; //Uint8List
        androidBitmap = ByteArrayAndroidBitmap.fromBase64String(base64Encode(imageBase64));
        styleInformation = BigPictureStyleInformation(androidBitmap);*/

        final Response response = await Dio().get(image, options: Options(responseType: ResponseType.bytes));
        error = "$error ${response.statusCode} ${response.data} ";

        Uint8List imageBase64 = response.data; //Uint8List
        androidBitmap = ByteArrayAndroidBitmap.fromBase64String(base64Encode(imageBase64));
        styleInformation = BigPictureStyleInformation(androidBitmap);
      } catch (er) {
        error = "$error $er";
        print(er);
      }

      error = " $error ${notification.body}";

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          "400",
          "404",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              playSound: true,
              icon: '@mipmap/ic_launcher_foreground',
              largeIcon: androidBitmap,
              styleInformation: styleInformation,
            ),
          ),
        );
      }
    });
  }

  checkAuthUser(authResult) {
    if (authResult) {
      return BottomNavigationBaseScreen();
    } else {
      return LoginScreen();
    }
  }
}
