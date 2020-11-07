class CommentReadDTO {
  int authorId;
  String authorName;
  Null authorAvatarSrc;
  String content;
  String createdAt;

  CommentReadDTO(
      {this.authorId,
      this.authorName,
      this.authorAvatarSrc,
      this.content,
      this.createdAt});

  CommentReadDTO.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    authorName = json['authorName'];
    authorAvatarSrc = json['authorAvatarSrc'];
    content = json['content'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['authorAvatarSrc'] = this.authorAvatarSrc;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    return data;
  }
}