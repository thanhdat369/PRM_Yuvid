import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/models/videoDTO.dart';

class VideoAPIService {
  Future<List<VideoDTO>> fetchAllVideo() async {
    final successCode = 200;
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/videos";
    // final json_body = json.encode(dto);
    // print(json_body);
    final response = await http.get(baseUrl);
    final responseString = jsonDecode(response.body)['result'] as List;
    List<VideoDTO> videos =
        responseString.map((p) => VideoDTO.fromJson(p)).toList();
    print(videos);
    return videos;
  }
}
