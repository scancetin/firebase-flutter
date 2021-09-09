class UserRequest {
  late String email;
  late String password;
  late bool returnSecureToken;

  UserRequest({required this.email, required this.password, required this.returnSecureToken});

  UserRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    returnSecureToken = json['returnSecureToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['returnSecureToken'] = this.returnSecureToken;
    return data;
  }
}
