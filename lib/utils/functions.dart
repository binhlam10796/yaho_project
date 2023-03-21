import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:yaho/core/models/object/device_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";
  String model = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String buildVersion = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  String packageName = packageInfo.packageName;

  try {
    if (Platform.isAndroid) {
      // return android device info
      var build = await deviceInfoPlugin.androidInfo;
      name = build.model;
      identifier = build.id;
      version = build.version.release;
      model = build.brand;
    } else if (Platform.isIOS) {
      // return ios device info
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name ?? "Unknown";
      identifier = build.identifierForVendor ?? "Unknown";
      version = build.systemVersion ?? "Unknown";
      model = build.model ?? "Unknown";
    }
  } on PlatformException {
    // return default data here
    return DeviceInfo(
        name, identifier, version, packageName, buildVersion, buildNumber,
        model: model);
  }
  return DeviceInfo(
      name, identifier, version, packageName, buildVersion, buildNumber,
      model: model);
}

String htmlToString(String htmlData) {
  RegExp regExp =
      RegExp(r"<[^>]*>|&[^;]+;", multiLine: true, caseSensitive: true);
  if (htmlData.contains(regExp)) {
    return htmlData.replaceAll(regExp, "");
  } else {
    return htmlData;
  }
}

// bool isEmailValid(String email) {
//   return RegExp(
//           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//       .hasMatch(email);
// }

// bool isPhoneValid(String phoneNumber) {
//   if (phoneNumber.contains("019006667") || phoneNumber.contains("19006667")) {
//     return true;
//   }
//   String pattern = r'^(?:[+0]9)?[0-9]{10}$';
//   RegExp regExp = RegExp(pattern);
//   return regExp.hasMatch(phoneNumber);
// }

// bool isUrlValid(String url) {
//   return RegExp(
//           r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
//           caseSensitive: false)
//       .hasMatch(url);
// }
