import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
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

  Future<bool> upload(VideoUploadDTO dto) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/videos";
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile(
      'VideoFile',
      dto.src.readAsBytes().asStream(),
      dto.src.lengthSync(),
      filename: dto.name,
      contentType: MediaType('video', 'mp4'),
    ));
    request.fields['name'] = dto.name;
    request.fields['Description'] = dto.description;
    request.fields['AuthorId'] = dto.authorId.toString();
    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print("RESS " + response.body);
      if (response.statusCode == 201) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<VideoDTO>> getVideoByUserID(int userID) async {
    final successCode = 200;
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/accounts/${userID}/videos";
    final response = await http.get(baseUrl);
    final responseString = jsonDecode(response.body) as List;
    List<VideoDTO> videos =
        responseString.map((p) => VideoDTO.fromJson(p)).toList();
    return videos;
  }

  Future<List<VideoDTO>> getVideoLiked() async {
    final successCode = 200;
    String baseUrl =
        "https://tiktok-prm.azurewebsites.net/api/accounts/${MockSession.id}/liked/videos";
    final response = await http.get(baseUrl);
    final responseString = jsonDecode(response.body) as List;
    List<VideoDTO> videos =
        responseString.map((p) => VideoDTO.fromJson(p)).toList();
    return videos;
  }
}
