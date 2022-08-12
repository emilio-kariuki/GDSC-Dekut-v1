import 'package:gdsc_app/UI/Announcement/Model/announcement_model.dart';

import '../UI/Events/Model/Event_model.dart';
import '../UI/Resources/Model/resources_model.dart';
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
  static void createAnnouncement(AnnouncementModel ann) async {
    firestoreInstance.collection('announcements').doc().set({
      "title": ann.title,
      "description": ann.description,
      "imageUrl": ann.imageUrl,
    });
  }
  static void createResource(ResourceModel res) async {
    firestoreInstance.collection('resources').doc().set({
      "title": res.title,
      "description": res.description,
      "imageUrl": res.imageUrl,
      "link": res.link,
    });
  }
}
