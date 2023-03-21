import 'package:yaho/common/route/navigation_service.dart';
import 'package:yaho/di/di.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final NavigationService navigationService = instance<NavigationService>();

  @override
  void start() {}

  @override
  void dispose() {}

  goBack() {
    navigationService.popCurrentScreen();
  }
}

abstract class BaseViewModelInputs {
  // Sink get inputAvatarData;
  /// This method is executed exactly once for each State object Flutter's
  /// framework creates.
  void start();

  ///  This method is executed whenever the Widget's Stateful State gets
  /// disposed. It might happen a few times, always matching the amount of times
  /// `init` is called.
  void dispose();

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  void routingDidPopNext() {}

  /// Called when the current route has been pushed.
  void routingDidPush() {}

  /// Called when the current route has been popped off.
  void routingDidPop() {}

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  void routingDidPushNext() {}
}

abstract class BaseViewModelOutputs {
  // Stream<String> get outputAvatarData;
}
