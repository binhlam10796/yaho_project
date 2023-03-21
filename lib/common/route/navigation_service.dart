import 'package:flutter/material.dart';
import 'package:yaho/common/dialog/error_dialog.dart';
import 'package:yaho/common/dialog/loading_dialog.dart';
import 'package:yaho/common/listener/listener.dart';
import 'package:yaho/common/route/route.dart';

enum DialogTypes {
  loading,
  error,
}

class NavigationService {
  bool isDialogShowing = false;
  bool isForceScreenShowing = false;
  bool isFirstOpenApp = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  openDialog({
    required DialogTypes types,
    required Map<String, dynamic> data,
    RightTapListener? rightTapListener,
    LeftTapListener? leftTapListener,
    SingleTapListener? singleTapListener,
    TryAgainTapListener? tryAgainTapListener,
    ConfirmTapListener? confirmTapListener,
    CarbonCopyTapListener? carbonCopyTapListener,
    bool byPassDismiss = true,
  }) {
    if (byPassDismiss) {
      dismissDialog();
    }
    Widget content = Container();
    switch (types) {
      case DialogTypes.loading:
        content = const LoadingDialog();
        break;
      case DialogTypes.error:
        content = ErrorDialog(
          title: data["title"] as String,
          message: data["message"] as String,
          singleTapListener: singleTapListener!,
        );
        break;
    }
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: content,
      ),
    );
    isDialogShowing = true;
  }

  dismissDialog() {
    if (_isThereCurrentDialogShowing(navigatorKey.currentContext!)) {
      isDialogShowing = false;
      popCurrentScreen();
    }
  }

  navigateTo(String routeName, {PopScreenListener? listener}) {
    return navigatorKey.currentState?.pushNamed(routeName).then((value) {
      if (listener != null) {
        listener(value);
      }
    });
  }

  navigateToWithArgs(String routeName,
      {Object? args, PopScreenListener? listener}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: args)
        .then((value) {
      if (listener != null) {
        listener(value);
      }
    });
  }

  popAllAndNavigateToWithArgs(String routeName, {Object? args}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      arguments: args,
      (Route<dynamic> route) => false,
    );
  }

  popAndNavigateTo(String routeName, {PopScreenListener? listener}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName)
        .then((value) {
      if (listener != null) {
        listener(value);
      }
    });
  }

  popAndNavigateToWithArgs(String routeName,
      {Object? args, PopScreenListener? listener}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: args)
        .then((value) {
      if (listener != null) {
        listener(value);
      }
    });
  }

  popCurrentScreen() {
    return navigatorKey.currentState?.pop();
  }

  popCurrentScreenWithData({Object? args}) {
    return navigatorKey.currentState?.pop(args);
  }

  popUntilScreen() {
    return navigatorKey.currentState?.popUntil((route) {
      if (route.settings.name != RoutePath.splashRoute) return false;
      return true;
    });
  }

  _isThereCurrentDialogShowing(BuildContext context) {
    return navigatorKey.currentState!.canPop() && isDialogShowing;
  }
}
