import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/models/commentDTO.dart';

class CommentService {
  final successCode = 200;

  Future<List<CommentReadDTO>> getCommentInVideo(int _videoId) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/videos/$_videoId/comments";
  
    List<CommentReadDTO> _list = List();
    // final json_body = json.encode(dto);
    // print(json_body);
    final response = await http.get(baseUrl);

    //if(response.statusCode == successCode) {
      
    if(response.statusCode == 404)
            throw Exception("No comments yet");

    _list = (json.decode(response.body) as List)
            .map((data) => new CommentReadDTO.fromJson(data))
            .toList();
    return _list;
  }

  Future<CommentPostDTO> postCommentInVideo(CommentPostDTO dto) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/comments";
  
    Map<String, String> headers = {
      "Content-type": "application/json-patch+json"
    };

    final json_body = json.encode(dto);
    print(json_body);
    print("service");
    final response = await http.post(baseUrl, headers: headers, body: json_body);
    if(response.body.contains("Error")) throw Exception("Error!!!");

    final responseString = jsonDecode(response.body);
    print(CommentPostDTO.fromJson(responseString));
    return CommentPostDTO.fromJson(responseString);

  }
}
