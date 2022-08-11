import '../UI/Events/Model/Event_model.dart';
import 'UserFirebase.dart';

class EventFirebase {
  static Future<List<EventModel>> getEvents() async {
    var data;
    await firestoreInstance.collection("events").doc().get().then((value) {
      data = value.data();
      print("The events are $data");
    });
    return eventFromJson(data);
  }

  static void createEvent(EventModel eve) async {
    firestoreInstance.collection('events').doc().set({
      "title": eve.title,
      "description": eve.description,
      "venue": eve.venue,
      "organizers": eve.organizers,
      "link": eve.registrationLink,
      "date": eve.date,
      "time": eve.time,
      "imageUrl": eve.imageUrl,
    });
  }
}
