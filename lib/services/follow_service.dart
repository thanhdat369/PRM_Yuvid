import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/models/followDTO.dart';

class FollowApiService {
  final successCode = 200;
  Future<List<AccountDTO>> getAllFollowings(int _accountId) async {
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/accounts/$_accountId/followings";

    List<AccountDTO> _list = List();
    final response = await http.get(baseUrl);

    if (response.statusCode == 404) throw Exception("No Following yet");

    _list = (json.decode(response.body) as List)
        .map((data) => new AccountDTO.fromJson(data))
        .toList();
    return _list;
  }

  Future<List<AccountDTO>> getAllFollower(int _accountId) async {
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/accounts/$_accountId/follower";

    final response = await http.get(baseUrl);

    List<AccountDTO> _list = List();

    if (response.statusCode == 404) throw Exception("No Following yet");

    _list = (json.decode(response.body) as List)
        .map((data) => new AccountDTO.fromJson(data))
        .toList();
    return _list;
  }

  Future<FollowReadDTO> getFollowID(int srcAccID, int desAccID) async {
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/follows/specific?srcId=${srcAccID}&desId=${desAccID}";

    final response = await http.get(baseUrl);

    if (response.statusCode == 404) {
      return null;
    }

    var followDTO = FollowReadDTO.fromJson(json.decode(response.body));
    return followDTO;
  }

  Future<bool> follow(int srcAccID, int desAccID) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/follows";
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };
    FollowPostDTO dto = FollowPostDTO(userId: srcAccID, followingId: desAccID);
    final json_body = json.encode(dto);
    print(json_body);

    final response =
        await http.post(baseUrl, headers: headers, body: json_body);

    if (response.statusCode == 201) {
      return true;
    } else
      return false;
  }

  Future<bool> unfollow(int srcAccID, int desAccID) async {
    FollowReadDTO followDTO = await getFollowID(srcAccID, desAccID);
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/follows/${followDTO.id}";

    final response = await http.delete(baseUrl);

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<bool> isFollow(int srcAccID, int desAccID) async {
    FollowReadDTO followDTO = await getFollowID(srcAccID, desAccID);
    return followDTO != null;
  }
}
