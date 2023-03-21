import 'package:flutter/material.dart';

enum LanguageType { english, vietnam }

const String vietnam = "vi";
const String english = "en";
const String assetsPathLocalisations = "assets/translations";
const Locale vietnamLocal = Locale("vi");
const Locale englishLocal = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.vietnam:
        return vietnam;
    }
  }
}
