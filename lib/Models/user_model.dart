class UserClass {
  late String name;
  late String email;
  late String password;

  UserClass(this.name,  this.email, this.password);

  Map<String, Object> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  UserClass.fromJson(Map<String, dynamic> json) {
    name = json['name']! as String;
    email = json['email']! as String;
    password = json['password']! as String;
  }
}
