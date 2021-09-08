class User {
  late int id;
  late String title;
  late int userId;

  User({required this.id, required this.title, required this.userId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['userId'] = this.userId;
    return data;
  }
}
