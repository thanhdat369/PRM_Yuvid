import 'package:prm_yuvid/models/commentDTO.dart';
import 'package:prm_yuvid/services/auth_service.dart';
import 'package:prm_yuvid/services/comment_service.dart';

class CommentRepo {
  CommentService commentService = CommentService();

  Future<List<CommentReadDTO>> getCommentInVideo(int videoId) =>
      commentService.getCommentInVideo(videoId);
}
