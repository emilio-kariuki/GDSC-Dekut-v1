import 'dart:convert';

import 'package:gdsc_app/Util/App_Constants.dart';

List<EventModel> eventFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));

class EventModel {
  String? title; //
  String? description; //
  String? date; //
  String? time; //
  String? venue; //
  String? registrationLink; //
  String? organizers;
  String? imageUrl;

  EventModel(
    this.title,
    this.description,
    this.date,
    this.time,
    this.venue,
    this.registrationLink,
    this.organizers,
    this.imageUrl,
  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'venue': venue,
        'registrationLink': registrationLink,
        'organizers': organizers,
        'imageUrl': imageUrl ?? Constants.announceLogo,
      };

  EventModel.fromJson(Map<String, dynamic> json) {
    title = json['title']! as String;
    description = json['description']! as String;
    date = json['date']! as String;
    time = json['time']! as String;
    venue = json['venue']! as String;
    registrationLink = json['registrationLink']! as String;
    organizers = json['organizers']! as String;
    imageUrl = json['imageUrl']! as String;
  }
}
