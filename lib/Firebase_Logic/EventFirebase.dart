import '../UI/Events/Model/Event_model.dart';
import 'UserFirebase.dart';

class ActionFirebase {


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
