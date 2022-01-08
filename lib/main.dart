import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Strings.dart';
import 'package:piramal_channel_partner/ui/login/login_screen.dart';
import 'package:piramal_channel_partner/utils/scroll_behavior.dart';

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
    return MaterialApp(
      title: kAppName,
      builder: (_, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: ThemeData(primarySwatch: Colors.deepOrange, scaffoldBackgroundColor: AppColors.white),
      home: LoginScreen(),
    );
  }
}
