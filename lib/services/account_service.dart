import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/models/accountDTO.dart';

class AccountApiProvider {
  final successCode = 200;

  Future<AccountDTO> login(String username, String password) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/authentication";
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };
    AccountAuthDTO dto = AccountAuthDTO(username: username, password: password);
    final json_body = json.encode(dto);
    print(json_body);
    final response =
        await http.post(baseUrl, headers: headers, body: json_body);
    print(response.body);
    // final responseString = jsonDecode(response.body);
    // print(responseString);

    // return parseResponse(response);
  }
}
