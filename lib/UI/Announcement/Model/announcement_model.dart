import 'package:gdsc_app/Util/App_Constants.dart';

class AnnouncementModel {
  String? title; //
  String? description; //
  String? link;
  String? imageUrl;

  AnnouncementModel(
    this.title,
    this.description,
    this.link,
    this.imageUrl,

  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'link': link,
        'imageUrl': imageUrl ?? Constants.announceLogo,
      };

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    title = json['title']! as String;
    description = json['description']! as String;
    link = json['link']! as String;
    imageUrl = json['imageUrl']! as String;
  }
}
