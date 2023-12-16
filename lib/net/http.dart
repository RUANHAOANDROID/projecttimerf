import 'package:http/http.dart';

import '../utils/http.dart';

class HttpManager {
  static int StatusSuccess = 0;
  static int StatusFail = 1;
  static Future<Map<String, dynamic>> getCustomers(requestBody) async {
    return await HttpUtils.post("/v1/customers", requestBody);
  }
}
