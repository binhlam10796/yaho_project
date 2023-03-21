import 'package:flutter/material.dart';
import 'package:yaho/common/resources/fonts_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color, {
  FontStyle? fontStyle,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    decoration: decoration,
  );
}

TextStyle getTextLightStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.light,
    color,
  );
}

TextStyle getTextRegularStyle({
  required double fontSize,
  required Color color,
  FontStyle? fontStyle,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.regular,
    color,
    fontStyle: fontStyle,
    decoration: decoration,
  );
}

TextStyle getTextMediumStyle({
  required double fontSize,
  required Color color,
  FontStyle? fontStyle,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.medium,
    color,
    fontStyle: fontStyle,
    decoration: decoration,
  );
}

TextStyle getTextSemiBoldStyle({
  required double fontSize,
  required Color color,
  FontStyle? fontStyle,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.semiBold,
    color,
    fontStyle: fontStyle,
    decoration: decoration,
  );
}

TextStyle getTextBoldStyle({
  required double fontSize,
  required Color color,
  FontStyle? fontStyle,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.bold,
    color,
    fontStyle: fontStyle,
    decoration: decoration,
  );
}
