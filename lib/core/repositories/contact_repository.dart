import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:yaho/core/models/mapper/contact.dart';
import 'package:yaho/core/network/error_handler.dart';
import 'package:yaho/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yaho/core/services/contact_service.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<Contact>>> fetchContact(int page);
}

class ContactRepositoryImpl extends ContactRepository {
  final ContactService _userService;
  final InternetConnectionChecker _networkInfo;

  ContactRepositoryImpl(this._userService, this._networkInfo);

  @override
  Future<Either<Failure, List<Contact>>> fetchContact(int page) async {
    if (await _networkInfo.hasConnection) {
      try {
        final response = await _userService.fetchContact(page);
        return Right(response.data?.map((v) => v.toDomain()).toList() ?? []);
      } catch (error) {
        if (error is DioError) {
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data["message"] ?? ResponseMessage.defaultError));
        }
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
