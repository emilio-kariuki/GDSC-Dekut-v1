import 'dart:convert';

import '../Util/App_Constants.dart';

List<UserClass> userFromJson(String str) =>
    List<UserClass>.from(json.decode(str).map((x) => UserClass.fromJson(x)));

class UserClass {
  String? name;
  String? email;
  String? phone;
  String? github;
  String? linkedin;
  String? twitter;
  String? userID;
  String? technology;
  String? imageUrl;


  UserClass(this.name, this.email, this.phone, this.github, this.linkedin,
      this.twitter, this.userID, this.technology, this.imageUrl);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'github': github,
        'linkedin': linkedin,
        'twitter': twitter,
        'userID': userID,
        'technology': technology,
        'imageUrl': imageUrl ?? Constants.announceLogo,
      };

  UserClass.fromJson(Map<String, dynamic> json) {
    name = json['name']! as String;
    email = json['email']! as String;
    phone = json['phone']! as String;
    github = json['github']! as String;
    linkedin = json['linkedin']! as String;
    twitter = json['twitter']! as String;
    userID = json['userID']! as String;
    technology = json['technology']! as String;
    imageUrl = json['imageUrl']! as String;

  }
}
//how to intergrate bank payment in flutter?
