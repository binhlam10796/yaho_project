import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yaho/core/network/curl_interceptor.dart';
import 'package:yaho/core/network/pretty_interceptor.dart';

const String applicationJson = "application/json";
const String applicationFormUrl = "application/x-www-form-urlencoded";
const String multipartFormData = "multipart/form-data";
const String textPlan = "text/plain";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String language = "Accept-Language";
const String xAppID = "x-app-id";
const String xAccessToken = "x-access-token";

Map<String, String> applicationJsonHeaders = {
  contentType: applicationJson,
  accept: "*/*",
};

Map<String, dynamic> applicationFormUrlHeaders = {
  contentType: applicationFormUrl,
  accept: "*/*",
};

Map<String, String> multipartFormDataHeaders = {
  contentType: multipartFormData,
  accept: "*/*",
};

Map<String, dynamic> textPlanHeaders = {
  contentType: textPlan,
  accept: "*/*",
};

class DioFactory {
  DioFactory();

  static Dio getDio({Map<String, dynamic>? header}) {
    Dio dio = Dio();

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyInterceptor(
          requestHeader: true, requestBody: true, responseHeader: true));
      dio.interceptors
          .add(CurlInterceptor(convertFormData: true, printOnSuccess: true));
    }
    return dio;
  }
}
