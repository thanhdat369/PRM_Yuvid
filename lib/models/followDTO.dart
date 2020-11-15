class FollowReadDTO {
  int id;
  int userId;
  int followingId;

  FollowReadDTO({this.id, this.userId, this.followingId});

  FollowReadDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    followingId = json['followingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['followingId'] = this.followingId;
    return data;
  }
}

class FollowPostDTO {
  int userId;
  int followingId;

  FollowPostDTO({this.userId, this.followingId});

  FollowPostDTO.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    followingId = json['followingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['followingId'] = this.followingId;
    return data;
  }
}
