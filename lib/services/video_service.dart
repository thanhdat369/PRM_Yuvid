import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
    request.files.add(http.MultipartFile(
      'src',
      dto.src.readAsBytes().asStream(),
      dto.src.lengthSync(),
      filename: dto.name,
      contentType: MediaType('video', 'mp4'),
    ));
    request.headers.addAll(headers);
    request.fields.addAll({
      "Name": "${dto.name}",
      "Description": "${dto.description}",
      "AuthorId": "${dto.authorId}"
    });
    print("request: " + request.toString());
  }
}
