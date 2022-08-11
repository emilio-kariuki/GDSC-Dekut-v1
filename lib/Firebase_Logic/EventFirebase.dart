import '../UI/Events/Model/Event_model.dart';
import 'UserFirebase.dart';

class EventFirebase{
  static Future<List<EventModel>> getEvents() async {
    var data;
    firestoreInstance.collection("events").doc().get().then((value) {
      data = value.data();
    });
    return eventFromJson(data);
  }
}