import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config = const {};

  static Future<void> initialize(String env) async {
    final configString = await rootBundle.loadString("assets/json/app_config.json");
    _config = (jsonDecode(configString) as Map<String, dynamic>)[env];
  }

  static String getDomainOne() {
    return _config['DOMAIN_ONE'] as String;
  }

  static String getDomainTwo() {
    return _config['DOMAIN_TWO'] as String;
  }
}
