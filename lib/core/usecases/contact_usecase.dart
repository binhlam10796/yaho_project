import 'package:dartz/dartz.dart';
import 'package:yaho/core/models/mapper/contact.dart';
import 'package:yaho/core/network/failure.dart';
import 'package:yaho/core/repositories/contact_repository.dart';

abstract class ContactUseCase {
  Future<Either<Failure, List<Contact>>> fetchContact(int page);
}

class ContactUseCaseImpl extends ContactUseCase {
  final ContactRepository _repository;

  ContactUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<Contact>>> fetchContact(int page) {
    return _repository.fetchContact(page);
  }
}
