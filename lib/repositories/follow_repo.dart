import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/services/follow_service.dart';

class FollowRepo {
  FollowApiService followApiService = FollowApiService();

  Future<List<AccountDTO>> getAllFollowing(int accountId) =>
      followApiService.getAllFollowings(accountId);

  Future<List<AccountDTO>> getAllFollowers(int accountId) =>
      followApiService.getAllFoolower(accountId);
}