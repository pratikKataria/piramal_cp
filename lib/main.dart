import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Strings.dart';
import 'package:piramal_channel_partner/ui/base/base_screen.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/home/home_screen.dart';
import 'package:piramal_channel_partner/ui/lead/lead_screen.dart';
import 'package:piramal_channel_partner/ui/myProfile/my_profile.dart';
import 'package:piramal_channel_partner/utils/scroll_behavior.dart';
import 'package:provider/provider.dart';

import 'ui/explore/explore_screen.dart';
import 'ui/lead/addLead/add_lead_screen.dart';
import 'utils/Utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Utility.statusBarAndNavigationBarColor();
  Utility.portrait();

  await Future.delayed(Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseProvider>(
      create: (_) => BaseProvider(),
      child: MaterialApp(
        title: kAppName,
        builder: (_, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: BaseScreen(child: child),
          );
        },
        theme: ThemeData(primarySwatch: Colors.deepOrange, scaffoldBackgroundColor: AppColors.white),
        home: ExploreScreen(),
      ),
    );
  }
}
