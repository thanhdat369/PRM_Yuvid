import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'dart:convert';

import 'package:prm_yuvid/models/accountDTO.dart';

class AccountApiProvider {
  Future<AccountDTO> login(String username, String password) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/authentication";
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };
    AccountAuthDTO dto = AccountAuthDTO(username: username, password: password);
    final json_body = json.encode(dto);
    final response =
        await http.post(baseUrl, headers: headers, body: json_body);
    if (response.body.contains("Invalid username"))
      throw Exception("Invalid username password");

    final responseString = jsonDecode(response.body);
    // print(AccountDTO.fromJson(responseString));
    return AccountDTO.fromJson(responseString);
  }

  Future<bool> editProfile(AccountEditDTO dto) async {
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/accounts/${MockSession.id}";
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };
    final json_body = json.encode(dto);
    print(json_body);
    final response = await http.put(baseUrl, headers: headers, body: json_body);
    if (response.statusCode == 204)
      return true;
    else
      return false;
  }

  Future<AccountSignUpDTO> signup(AccountSignUpDTO dto) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/accounts";
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };
    //AccountAuthDTO dto = AccountAuthDTO(username: username, password: password);
    final json_body = json.encode(dto);
    print(json_body);
    final response =
        await http.post(baseUrl, headers: headers, body: json_body);
    if (response.body.contains("Error")) throw Exception("Existed usename");

    final responseString = jsonDecode(response.body);
    print(AccountSignUpDTO.fromJson(responseString));
    return AccountSignUpDTO.fromJson(responseString);
  }

  Future<bool> editAvt(File imageFile) async {
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/accounts/${MockSession.id}/avatar";
    var request = http.MultipartRequest('PUT', Uri.parse(baseUrl));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.headers.addAll(headers);
    print(imageFile.path);
    request.files.add(await http.MultipartFile(
      'avatarFile',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: imageFile.path.split('/').last,
      contentType: MediaType('image', 'jpeg'),
    ));

    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print("RESS " + response.body);
      if (response.statusCode == 204) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
