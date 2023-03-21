import 'dart:async';

import 'package:dio/dio.dart';
import 'package:yaho/common/resources/values_manager.dart';
import 'package:yaho/core/network/dio_factory.dart';

import 'api_request_representable.dart';

class APIProvider {
  final Dio _dio = DioFactory.getDio();

  static final _singleton = APIProvider();

  static APIProvider get instance => _singleton;

  Future request(APIRequestRepresentable request) async {
    final response = await _dio.request(
      request.urls,
      data: request.bodies,
      queryParameters: request.queries,
      options: Options(
        method: request.methods.string,
        headers: request.headers,
        receiveTimeout: const Duration(seconds: DurationConstant.d60),
        sendTimeout: const Duration(seconds: DurationConstant.d60),
      ),
    );
    return response.data;
  }
}
