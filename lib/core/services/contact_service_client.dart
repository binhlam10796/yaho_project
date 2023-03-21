import 'package:yaho/app/flavors/config_reader.dart';
import 'package:yaho/core/network/api_provider.dart';
import 'package:yaho/core/network/api_request_representable.dart';

enum ContactServiceType {
  fetchUser,
}

class ContactServiceClient implements APIRequestRepresentable {
  final ContactServiceType type;
  final int? page;

  ContactServiceClient._({
    required this.type,
    required this.page,
  });

  ContactServiceClient.fetchContact(int page)
      : this._(type: ContactServiceType.fetchUser, page: page);

  @override
  get bodies => null;

  @override
  String get endpoints => ConfigReader.getDomainOne();

  @override
  Map<String, String>? get headers => {
        "content-type": "application/json",
        "accept": "*/*",
      };

  @override
  HTTPMethod get methods => HTTPMethod.get;

  @override
  String get paths {
    switch (type) {
      case ContactServiceType.fetchUser:
        return "users";
    }
  }

  @override
  Map<String, String>? get queries {
    switch (type) {
      case ContactServiceType.fetchUser:
        return {"page": "$page"};
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get urls => endpoints + paths;
}
