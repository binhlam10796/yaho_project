import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/common/route/route.dart';
import 'package:yaho/di/di.dart';
import 'package:yaho/presentation/contact/view/contact_screen.dart';
import 'package:yaho/presentation/splash/view/splash_screen.dart';
import 'package:yaho/presentation/welcome/view/welcome_screen.dart';

class RouteBuilder {
  static Route<dynamic> route(RouteSettings settings) {
    /// Custom page route with slide right animation
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation) {
        final args = settings.arguments;
        if (kDebugMode) {
          print(settings.name);
        }
        switch (settings.name) {
          case RoutePath.splashRoute:
            initSplashModule();
            return const SplashScreen();
          case RoutePath.welcomeRoute:
            return const WelcomeScreen();
          case RoutePath.contactRoute:
            initContactModule();
            return ContactScreen();
          default:
            return unDefinedRoute();
        }
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: DurationConstant.d150),
      reverseTransitionDuration:
          const Duration(milliseconds: DurationConstant.d150),
      maintainState: true,
    );
  }

  static unDefinedRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound).tr(),
      ),
      body: Center(child: const Text(AppStrings.noRouteFound).tr()),
    );
  }
}
