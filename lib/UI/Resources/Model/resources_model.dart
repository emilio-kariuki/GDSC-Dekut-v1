import 'package:gdsc_app/Util/App_Constants.dart';

class ResourceModel {
  late String title; //
  late String description;

  String? imageUrl;
    late String link;

  ResourceModel(this.title, this.description, this.imageUrl, this.link);

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'imageUrl': imageUrl ?? Constants.announceLogo,
        'link': link,
      };

  ResourceModel.fromJson(Map<String, dynamic> json) {
    title = json['title']! as String;
    description = json['description']! as String;
    imageUrl = json['imageUrl']! as String;
    link = json['link']! as String;
  }
}
