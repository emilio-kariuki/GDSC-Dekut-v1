import 'package:gdsc_app/Util/App_Constants.dart';

class AnnouncementModel {
  late String title; //
  late String description; //

  String? imageUrl;

  AnnouncementModel(
    this.title,
    this.description,
    this.imageUrl,
  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'imageUrl': imageUrl ?? Constants.announceLogo,
      };

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    title = json['title']! as String;
    description = json['description']! as String;

    imageUrl = json['imageUrl']! as String;
  }
}
