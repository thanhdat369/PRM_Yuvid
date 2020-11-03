import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/services/video_service.dart';

class VideoRepo {
  VideoAPIService videoAPIService = VideoAPIService();
  Future<List<VideoDTO>> fetchAllVideo() => videoAPIService.fetchAllVideo();
}
