import 'dart:io';

class VideoDTO {
  int id;
  String name;
  String src;
  String description;
  int authorId;
  String authorName;
  String authorAvatarSrc;
  String createdAt;
  List<int> likedAccount;

  VideoDTO(
      {this.id,
      this.name,
      this.src,
      this.description,
      this.authorId,
      this.authorName,
      this.authorAvatarSrc,
      this.createdAt,
      this.likedAccount});

  VideoDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    description = json['description'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    authorAvatarSrc = json['authorAvatarSrc'];
    createdAt = json['createdAt'];
    likedAccount = json['likedAccount'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['src'] = this.src;
    data['description'] = this.description;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['authorAvatarSrc'] = this.authorAvatarSrc;
    data['createdAt'] = this.createdAt;
    data['likedAccount'] = this.likedAccount;
    return data;
  }
}

class VideoUploadDTO {
  String name;
  File src;
  String description;
  int authorId;
  String createdAt;

  VideoUploadDTO(
      {this.name, this.src, this.description, this.authorId, this.createdAt});

  VideoUploadDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    src = json['src'];
    description = json['description'];
    authorId = json['authorId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['src'] = this.src;
    data['description'] = this.description;
    data['authorId'] = this.authorId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
