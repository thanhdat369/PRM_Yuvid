class CommentReadDTO {
  int id;
  int authorId;
  int videoId;
  String content;
  String createdAt;

  CommentReadDTO(
      {this.id, this.authorId, this.videoId, this.content, this.createdAt});

  CommentReadDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['authorId'];
    videoId = json['videoId'];
    content = json['content'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['authorId'] = this.authorId;
    data['videoId'] = this.videoId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    return data;
  }
}