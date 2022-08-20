import 'dart:convert';

List<UserClass> userFromJson(String str) =>
    List<UserClass>.from(json.decode(str).map((x) => UserClass.fromJson(x)));

class UserClass {
  late String name;
  late String email;
  late String password;
  late String userID;
  late String technology;

  UserClass(this.name, this.email, this.password, this.userID, this.technology);

  Map<String, Object> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'userID': userID,
      'technology': technology,
    };
  }

  UserClass.fromJson(Map<String, dynamic> json) {
    name = json['name']! as String;
    email = json['email']! as String;
    password = json['password']! as String;
    userID = json['userID']! as String;
    technology = json['technology']! as String;
  }
}
