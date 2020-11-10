import 'package:prm_yuvid/services/likes_service.dart';

class LikesRepository {
  LikeApiProvider likeApiProvider = LikeApiProvider();

  Future<bool> likeVideo(int videoId, int accountId) =>
      likeApiProvider.likeVideo(videoId, accountId);

  Future<bool> unLikeVideo(int videoId, int accountId) =>
      likeApiProvider.unLikeVideo(videoId, accountId);
}
