import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/dataStruct/stack.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:provider/provider.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class RouteTransition extends PageRouteBuilder {
  final Widget widget;
  StackSetDSA<String> screenStack = StackSetDSA<String>();

  RouteTransition({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
            baseProvider.screenStack.push("$widget");
            return WillPopScope(
                onWillPop: () {
                  if (baseProvider.screenStack.isNotEmpty){
                    baseProvider.screenStack.pop();
                  }

                  if (baseProvider.screenStack.isEmpty) {
                    baseProvider.currentScreen = Screens.kHomeScreen;
                    baseProvider.setBottomNavScreen(baseProvider.currentScreen);
                  }

                  Navigator.pop(context);
                  return;
                },
                child: widget);
          },
          transitionDuration: Duration(milliseconds: 800),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              fillColor: Theme.of(context).cardColor,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },

          /*   transitionsBuilder: (BuildContext context, Animation<double>animation,
          Animation<double>secondaryAnimation, Widget child) {
        return new SlideTransition(position: new Tween<Offset>(

          begin: const Offset(0.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
          child: child,);
      }*/
        );
}
