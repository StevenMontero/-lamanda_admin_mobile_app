class AdminUser {
  String? id;
  String? userName;
  String? email;
  String? password;
  String? photoUri;

  AdminUser({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.photoUri,
  });

  AdminUser.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userName = json['userName'];
    this.email = json['email'];
    this.password = json['password'];
    this.photoUri = json['photoUri'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'userName': this.userName,
      'email': this.email,
      'password': this.password,
      'photoUri': this.photoUri,
    };
  }
}
