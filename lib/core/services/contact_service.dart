import 'package:yaho/core/models/response/base_response.dart';
import 'package:yaho/core/models/response/contact_response/contact_parser.dart';
import 'package:yaho/core/models/response/contact_response/contact_response.dart';
import 'package:yaho/core/services/contact_service_client.dart';

abstract class ContactService {
  Future<BaseResponse<List<ContactResponse?>>> fetchContact(int page);
}

class ContactServiceImpl implements ContactService {
  @override
  Future<BaseResponse<List<ContactResponse?>>> fetchContact(int page) async {
    var response = await ContactServiceClient.fetchContact(page).request();
    final parser = ContactParser(response);
    return parser.parseInBackground();
  }
}
