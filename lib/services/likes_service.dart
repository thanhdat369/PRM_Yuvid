import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class LikeApiProvider {
  final successCode = 200;
  Future<bool> likeVideo(int _videoId, int _accountId) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/likes";
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };
    Map<String, int> json_body_map = {
      "accountId": _accountId,
      "videoId": _videoId,
    };
    var json_body = json.encode(json_body_map);
    final response =
        await http.post(baseUrl, headers: headers, body: json_body);

    if (response.statusCode == 201)
      return true;
    else
      return false;
  }

  Future<bool> unLikeVideo(int _videoId, int _accountId) async {
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/likes?accountId=$_accountId&videoId=$_videoId";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.delete(baseUrl, headers: headers);

    if (response.statusCode == 204)
      return true;
    else
      return false;
  }
}
