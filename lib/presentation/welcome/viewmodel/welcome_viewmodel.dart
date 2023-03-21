import 'package:yaho/common/route/navigation_service.dart';
import 'package:yaho/common/route/route_path.dart';
import 'package:yaho/presentation/base/base_viewmodel.dart';
import 'package:yaho/di/di.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = instance<NavigationService>();

  goToLoginScreen() {
    _navigationService.popAndNavigateTo(RoutePath.contactRoute);
  }
}
