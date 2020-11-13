import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/services/video_service.dart';

class VideoRepo {
  VideoAPIService videoAPIService = VideoAPIService();
  Future<VideoDTO> getVideoByPage(int pageVideo) =>
      videoAPIService.getVideoByPage(pageVideo);
  Future<bool> upload(VideoUploadDTO dto) => videoAPIService.upload(dto);
  Future<List<VideoDTO>> getVideoByUserID(int userID) =>
      videoAPIService.getVideoByUserID(userID);
  Future<List<VideoDTO>> getVideoLiked() => videoAPIService.getVideoLiked();
}
