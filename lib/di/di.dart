import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:yaho/common/route/navigation_service.dart';
import 'package:yaho/core/repositories/contact_repository.dart';
import 'package:yaho/core/services/contact_service.dart';
import 'package:yaho/core/usecases/contact_usecase.dart';
import 'package:yaho/presentation/contact/viewmodel/contact_viewmodel.dart';
import 'package:yaho/presentation/splash/viewmodel/splash_viewmodel.dart';
import 'package:yaho/presentation/welcome/viewmodel/welcome_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  instance.registerLazySingleton<NavigationService>(() => NavigationService());

  instance.registerLazySingleton<ContactService>(() => ContactServiceImpl());

  instance.registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImpl(instance(), instance()));
}

initSplashModule() {
  if (!GetIt.I.isRegistered<SplashViewModel>()) {
    instance.registerFactory<SplashViewModel>(() => SplashViewModel());
  }
  if (!GetIt.I.isRegistered<WelcomeViewModel>()) {
    instance.registerFactory<WelcomeViewModel>(() => WelcomeViewModel());
  }
}

initContactModule() {
  if (!GetIt.I.isRegistered<ContactService>()) {
    instance.registerFactory<ContactService>(() => ContactServiceImpl());
  }
  if (!GetIt.I.isRegistered<ContactRepository>()) {
    instance.registerFactory<ContactRepository>(
        () => ContactRepositoryImpl(instance(), instance()));
  }
  if (!GetIt.I.isRegistered<ContactUseCase>()) {
    instance
        .registerFactory<ContactUseCase>(() => ContactUseCaseImpl(instance()));
  }
  if (!GetIt.I.isRegistered<ContactViewModel>()) {
    instance
        .registerFactory<ContactViewModel>(() => ContactViewModel(instance()));
  }
}
