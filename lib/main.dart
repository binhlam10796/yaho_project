import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:yaho/app/flavors/config_reader.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/common/route/navigation_service.dart';
import 'package:yaho/common/route/route.dart';
import 'package:yaho/common/widgets/dismiss_keyboard.dart';
import 'package:yaho/di/di.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  await ConfigReader.initialize(env);
  runApp(EasyLocalization(
    supportedLocales: const [englishLocal, vietnamLocal],
    path: assetsPathLocalisations,
    fallbackLocale: vietnamLocal,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        builder: EasyLoading.init(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteBuilder.route,
        navigatorKey: instance<NavigationService>().navigatorKey,
        scaffoldMessengerKey:
            instance<NavigationService>().scaffoldMessengerKey,
        initialRoute: RoutePath.splashRoute,
      ),
    );
  }
}
