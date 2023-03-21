import 'package:yaho/app/flavors/environment.dart';
import 'package:yaho/main.dart';

/// In Dev Env - Dummies database will be used.
Future<void> main() async {
  await mainCommon(Environment.dev);
}
