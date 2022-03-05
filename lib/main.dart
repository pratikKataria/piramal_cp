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
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home_bottom_navigation_base_screen.dart';
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
import 'package:piramal_channel_partner/utils/scroll_behavior.dart';
import 'package:provider/provider.dart';

import 'ui/core/login/login_screen.dart';
import 'ui/myAssit/assist/my_assist_screen.dart';
import 'ui/projectsFlo/projectDetail/project_detail_screen.dart';
import 'user/AuthUser.dart';
import 'utils/Utility.dart';
import 'utils/navigator_gk.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    showBadge: true,
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Utility.statusBarAndNavigationBarColor();
  await Utility.portrait();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

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
              return RouteTransition(widget: HomeBottomNavigationBaseScreen());
              break;
            case Screens.kHomeBase:
              return RouteTransition(widget: HomeBottomNavigationBaseScreen());
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
              return RouteTransition(widget: SignupScreen());
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
            default:
              return RouteTransition(widget: HomeBottomNavigationBaseScreen());
              break;
          }
        },
        home: checkAuthUser(authResult),
      ),
    );
  }

  void RegisterFirebaseNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("Message Received: ${message.data}");

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                icon: '@drawable/ic_app_logo',
              ),
            ));
      }
    });
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }


  checkAuthUser(authResult) {
    if (authResult) {
      return HomeBottomNavigationBaseScreen();
    } else {
      return LoginScreen();
    }
  }
}

/*



    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });



*/