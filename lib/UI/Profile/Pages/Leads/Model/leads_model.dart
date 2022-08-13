import 'package:gdsc_app/Util/App_Constants.dart';

class LeadsModel {
  String? name; //
  String? role;
  String? imageUrl;
  String? phone;
  String? email;

  LeadsModel(this.name, this.role, this.imageUrl,this.phone,this.email);

  Map<String, dynamic> toJson() => {
        'title': name,
        'description': role,
        'imageUrl': imageUrl ?? Constants.announceLogo,
        'phone': phone,
        'email': email
      };

  LeadsModel.fromJson(Map<String, dynamic> json) {
    name = json['title']! as String;
    role = json['description']! as String;
    imageUrl = json['imageUrl']! as String;
    phone = json['phone']! as String;
    email = json['email']! as String;
  }
}
