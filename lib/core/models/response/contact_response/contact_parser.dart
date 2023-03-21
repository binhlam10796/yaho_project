import 'dart:isolate';

import 'package:yaho/core/models/response/base_response.dart';
import 'package:yaho/core/models/response/contact_response/contact_response.dart';

class ContactParser {
  ContactParser(this.response);

  final dynamic response;

  Future<BaseResponse<List<ContactResponse?>>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort p) async {
    final results = BaseResponse<List<ContactResponse>>.fromJson(
      response,
      (json) => (json as List<dynamic>)
          .map<ContactResponse>(
              (i) => ContactResponse.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    Isolate.exit(p, results);
  }
}
