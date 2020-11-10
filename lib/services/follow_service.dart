import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FollowApiService {
  final successCode = 200;
  Future<List<AccountDTO>> getAllFollowings(int _accountId) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/accounts/$_accountId/followings";

    List<AccountDTO> _list = List();
    final response =
    await http.get(baseUrl);

    if(response.statusCode == 404)
      throw Exception("No Following yet");

    _list = (json.decode(response.body) as List)
        .map((data) => new AccountDTO.fromJson(data))
        .toList();
    return _list;
  }

  Future<List<AccountDTO>> getAllFoolower(int _accountId) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/accounts/$_accountId/follower";

    final response =
    await http.get(baseUrl);
    
    List<AccountDTO> _list = List();

    if(response.statusCode == 404)
      throw Exception("No Following yet");

    _list = (json.decode(response.body) as List)
        .map((data) => new AccountDTO.fromJson(data))
        .toList();
    return _list;
  }
}