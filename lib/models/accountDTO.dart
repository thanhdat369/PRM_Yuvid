class AccountDTO {
  int id;
  String username;
  String email;
  String name;
  String avatarSrc;
  String bio;

  AccountDTO(
      {this.id,
      this.username,
      this.email,
      this.name,
      this.avatarSrc,
      this.bio});

  AccountDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    avatarSrc = json['avatarSrc'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatarSrc'] = this.avatarSrc;
    data['bio'] = this.bio;
    return data;
  }
}

class AccountAuthDTO {
  String username;
  String password;

  AccountAuthDTO({this.username, this.password});

  AccountAuthDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class AccountEditDTO {
  String email;
  String name;
  String bio;

  AccountEditDTO({this.email, this.name, this.bio});

  AccountEditDTO.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['bio'] = this.bio;
    return data;
  }
}

class AccountSignUpDTO {
  String username;
  String password;
  String email;
  String name;
  String bio;

  AccountSignUpDTO(
      {this.username, this.password, this.email, this.name, this.bio});

  AccountSignUpDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['name'] = this.name;
    data['bio'] = this.bio;
    return data;
  }
}
