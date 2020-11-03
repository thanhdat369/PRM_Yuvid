class VideoDTO {
  int id;
  Null name;
  String src;
  String description;
  int authorId;
  Null authorName;
  String createdAt;

  VideoDTO(
      {this.id,
      this.name,
      this.src,
      this.description,
      this.authorId,
      this.authorName,
      this.createdAt});

  VideoDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    description = json['description'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['src'] = this.src;
    data['description'] = this.description;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
