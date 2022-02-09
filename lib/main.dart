import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:piramal_channel_partner/ui/lead/lead_screen.dart';
import 'package:piramal_channel_partner/ui/myAssit/my_assist_screen.dart';
import 'package:piramal_channel_partner/ui/myProfile/my_profile.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/project_screen.dart';
import 'package:piramal_channel_partner/utils/scroll_behavior.dart';
import 'package:provider/provider.dart';

import 'ui/core/login/login_screen.dart';
import 'ui/projectsFlo/projectDetail/project_detail_screen.dart';
import 'user/AuthUser.dart';
import 'utils/Utility.dart';
import 'utils/navigator_gk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Utility.statusBarAndNavigationBarColor();
  Utility.portrait();

  bool authResult = await (AuthUser.getInstance()).isLoggedIn();

  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp(authResult));
}

class MyApp extends StatelessWidget {
  final bool authResult;

  const MyApp(this.authResult, {Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
              return RouteTransition(widget: WalkinCustomerProfileDetailScreen());
              break;
            case Screens.kCustomerProfileDetailBooking:
              return RouteTransition(widget: const BookedCustomerProfileDetailScreen());
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
              return RouteTransition(widget: MyAssistScreen());
              break;
            case Screens.kSettingsScreen:
              return RouteTransition(widget: MyProfileScreen());
              break;
            case Screens.kAddLeadScreen:
              return RouteTransition(widget: AddLeadScreen());
              break;
            case Screens.kProjectDetailScreen:
              return RouteTransition(widget: ProjectDetailScreen());
              break;
            case Screens.kLoginScreen:
              return RouteTransition(widget: LoginScreen());
              break;
            case Screens.kSignupScreen:
              return RouteTransition(widget: SignupScreen());
              break;
            case Screens.kUploadDocumentScreen:
              return RouteTransition(widget: UploadDocumentScreen());
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

  checkAuthUser(authResult) {
    if (authResult) {
      return HomeBottomNavigationBaseScreen();
    } else {
      return LoginScreen();
    }
  }
}
