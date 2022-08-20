import 'dart:convert';

import 'package:gdsc_app/Util/App_Constants.dart';

List<MeetingModel> eventFromJson(String str) =>
    List<MeetingModel>.from(json.decode(str).map((x) => MeetingModel.fromJson(x)));

class MeetingModel {
  String? title; //
  String? description; //
  String? date; //
  String? time; //
//
  String? registrationLink; //
  String? organizers;
  String? imageUrl;

  MeetingModel(
    this.title,
    this.description,
    this.date,
    this.time,

    this.registrationLink,
    this.organizers,
    this.imageUrl,
  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'time': time,

        'registrationLink': registrationLink,
        'organizers': organizers,
        'imageUrl': imageUrl ?? Constants.announceLogo,
      };

  MeetingModel.fromJson(Map<String, dynamic> json) {
    title = json['title']! as String;
    description = json['description']! as String;
    date = json['date']! as String;
    time = json['time']! as String;
    registrationLink = json['registrationLink']! as String;
    organizers = json['organizers']! as String;
    imageUrl = json['imageUrl']! as String;
  }
}
