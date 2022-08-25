import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gdsc_app/UI/Announcement/Model/announcement_model.dart';
import 'package:gdsc_app/UI/Meetings/Model/meetings_model.dart';
import 'package:gdsc_app/UI/Profile/Pages/FeedBack/Model/feedback.dart';
import 'package:gdsc_app/UI/Profile/Pages/Leads/Model/leads_model.dart';

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
    }, SetOptions(merge: true));
  }

  static void createFeedback(FeedBackModel feedback) {
    firestoreInstance.collection('feedback').doc().set({
      "name": feedback.title,
      "email": feedback.description,
    });
  }

  static void createMeeting(MeetingModel eve) async {
    firestoreInstance.collection('meetings').doc().set({
      "title": eve.title,
      "description": eve.description,
      "organizers": eve.organizers,
      "link": eve.registrationLink,
      "date": eve.date,
      "time": eve.time,
      "imageUrl": eve.imageUrl,
    }, SetOptions(merge: true));
  }

  static void createAnnouncement(AnnouncementModel ann) async {
    firestoreInstance.collection('announcements').doc().set({
      "title": ann.title,
      "description": ann.description,
      "link": ann.link ?? "No link",
      "imageUrl": ann.imageUrl,
    }, SetOptions(merge: true));
  }

  static void createResource(ResourceModel res) async {
    firestoreInstance.collection('resources').doc().set({
      "title": res.title,
      "description": res.description,
      "imageUrl": res.imageUrl,
      "link": res.link,
    }, SetOptions(merge: true));
  }

  static void createLead(LeadsModel lead) async {
    firestoreInstance.collection('leads').doc().set({
      "name": lead.name,
      "role": lead.role,
      "imageUrl": lead.imageUrl,
      "phone": lead.phone,
      "email": lead.email
    }, SetOptions(merge: true));
  }

  static void deleteDoc(String id, String collection) async {
    firestoreInstance.collection(collection).doc(id).delete();
  }
}
