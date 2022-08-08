class userClass {
  late String name;
  String email;
  String password;

  userClass({required this.name, required this.email, required this.password});

  Map<String, Object> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  userClass.fromJson(Map<String, dynamic> json) {
    name = json['name']! as String;
    email = json['email']! as String;
    password = json['password']! as String;
  }
}
