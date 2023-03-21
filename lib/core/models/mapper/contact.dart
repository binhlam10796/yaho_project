import 'package:equatable/equatable.dart';
import 'package:yaho/core/models/response/contact_response/contact_response.dart';

class Contact extends Equatable {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  const Contact({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  @override
  List<Object?> get props => [email, firstName, lastName];
}

extension UserResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
      id: this?.id ?? 0,
      email: this?.email ?? "",
      firstName: this?.firstName ?? "",
      lastName: this?.lastName ?? "",
      avatar: this?.avatar ?? "",
    );
  }
}
