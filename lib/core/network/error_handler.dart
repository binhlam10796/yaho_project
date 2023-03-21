import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaho/common/resources/strings_manager.dart';
import 'package:yaho/core/network/failure.dart';

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    if (error.response?.data["code"] != null &&
        error.response?.data["message"] != null) {
      return Failure(error.response?.statusCode ?? ResponseCode.defaultError,
          error.response?.data["message"] ?? error.response?.statusMessage);
    }
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.unknown:
        if (error.response?.data["code"] != null &&
            error.response?.data["message"] != null) {
          return Failure(
              error.response?.statusCode ?? ResponseCode.defaultError,
              error.response?.data["message"] ?? error.response?.statusMessage);
        }
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
      case DioErrorType.badCertificate:
        return Failure(
              error.response?.statusCode ?? ResponseCode.defaultError,
              error.response?.data["message"] ?? error.response?.statusMessage);
      case DioErrorType.connectionError:
        return Failure(
              error.response?.statusCode ?? ResponseCode.defaultError,
              error.response?.data["message"] ?? error.response?.statusMessage);
    }
  }
}

class ResponseCode {
  // API status codes
  static const int success = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int notAcceptable = 406;
  static const int internalServerError = 500;

  // local status codes
  static const int defaultError = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  static String success = AppStrings.success.tr();
  static String noContent = AppStrings.noContent.tr();
  static String badRequest = AppStrings.badRequestError.tr();
  static String forbidden = AppStrings.forbiddenError.tr();
  static String unauthorized = AppStrings.unauthorizedError.tr();
  static String notFound = AppStrings.notFoundError.tr();
  static String internalServerError = AppStrings.internalServerError.tr();
  static String defaultError = AppStrings.defaultError.tr();
  static String connectTimeout = AppStrings.timeoutError.tr();
  static String cancel = AppStrings.defaultError.tr();
  static String receiveTimeout = AppStrings.timeoutError.tr();
  static String sendTimeout = AppStrings.timeoutError.tr();
  static String cacheError = AppStrings.defaultError.tr();
  static String noInternetConnection = AppStrings.noInternetError.tr();
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
      default:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}
