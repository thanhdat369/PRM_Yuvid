import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/models/videoDTO.dart';

class VideoAPIService {
  Future<VideoDTO> getVideoByPage(int vidPage) async {
    final successCode = 200;
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/videos?page=$vidPage&limit=1";
    // final json_body = json.encode(dto);
    // print(json_body);
    final response = await http.get(baseUrl);
    final responseString = jsonDecode(response.body)['result'] as List;
    List<VideoDTO> videos =
        responseString.map((p) => VideoDTO.fromJson(p)).toList();
    return videos.first;
  }
}
