import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/services/follow_service.dart';

class FollowRepo {
  FollowApiService followApiService = FollowApiService();

  Future<List<AccountDTO>> getAllFollowing(int accountId) =>
      followApiService.getAllFollowings(accountId);

  Future<List<AccountDTO>> getAllFollowers(int accountId) =>
      followApiService.getAllFollower(accountId);
  Future<bool> follow(int srcAccID, int desAccID) =>
      followApiService.follow(srcAccID, desAccID);
  Future<bool> unfollow(int srcAccID, int desAccID) =>
      followApiService.unfollow(srcAccID, desAccID);
  Future<bool> isFollow(int srcAccID, int desAccID) =>
      followApiService.isFollow(srcAccID, desAccID);
}
