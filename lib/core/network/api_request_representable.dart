enum HTTPMethod { get, post, delete, put, patch }

extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "get";
      case HTTPMethod.post:
        return "post";
      case HTTPMethod.delete:
        return "delete";
      case HTTPMethod.patch:
        return "patch";
      case HTTPMethod.put:
        return "put";
    }
  }
}

abstract class APIRequestRepresentable {
  String get urls;

  String get endpoints;

  String get paths;

  HTTPMethod get methods;

  Map<String, String>? get headers;

  Map<String, String>? get queries;

  dynamic get bodies;

  Future request();
}
