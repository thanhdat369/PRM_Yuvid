import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/models/commentDTO.dart';

class CommentService {
  final successCode = 200;

  Future<List<CommentReadDTO>> getCommentInVideo(int _videoId) async {
    String baseUrl = "https://tiktok-prm.azurewebsites.net/api/comments";
  
    List<CommentReadDTO> _list = List();
    List<CommentReadDTO> _listed = List();
    // final json_body = json.encode(dto);
    // print(json_body);
    final response = await http.get(baseUrl);

    //if(response.statusCode == successCode) {
      
    if(response.statusCode == 404)
            throw Exception("No comments yet");

    _list = (json.decode(response.body) as List)
            .map((data) => new CommentReadDTO.fromJson(data))
            .toList();
      
    _listed = _list.where((i) => i.videoId == _videoId).toList();
    print(_listed);
    return _listed;
  }
}
