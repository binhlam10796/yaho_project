import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/common/route/route.dart';
import 'package:yaho/core/models/object/device_info.dart';
import 'package:yaho/presentation/base/base_viewmodel.dart';
import 'package:yaho/utils/functions.dart';

class SplashViewModel extends BaseViewModel
    with SplashViewModelInputs, SplashViewModelOutputs {
  final _versionNameController = BehaviorSubject<String>();

  Timer? _timer;

  @override
  Sink get inputVersionName => _versionNameController.sink;

  @override
  Stream<String> get outputVersionName =>
      _versionNameController.map((data) => data);

  @override
  void dispose() {
    _timer?.cancel();
  }

  @override
  void start() {
    _getVersionName();
    _timer =
        Timer.periodic(const Duration(seconds: DurationConstant.d2), (timer) {
      /// Go to welcome screen
      navigationService.popAndNavigateTo(RoutePath.welcomeRoute);
      timer.cancel();
    });
  }

  _getVersionName() async {
    DeviceInfo info = await getDeviceDetails();
    inputVersionName.add("${info.buildVersion} (${info.buildNumber})");
  }
}

abstract class SplashViewModelInputs {
  Sink get inputVersionName;
}

abstract class SplashViewModelOutputs {
  Stream<String> get outputVersionName;
}
