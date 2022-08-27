import 'dart:convert';

import 'package:gdsc_app/Util/App_components.dart';
import 'package:http/http.dart' as http;

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}

class FirebaseNotification {
  static var client = http.Client();
  static Future<void> sendFirebaseNotification(
      {required String purpose,required String title}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    
    final data = {
      "to": "/topics/Name",
      'notification': {

        'title': "New $purpose Added",

        'body': title,

      },
      'priority': 'high',
      'data': {
        "type": "notification",
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
      },
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAta6X3Qk:APA91bGweK3WrC4RhucqVV29O__UAyeCbu-Jen34MTdaxlzux6QvwENfPCRwoPXMDnHQJTJ_f3lsvafud24OnQzbri2o12Y_YB7dXWdPcA71aHc00Cds5ZnF_JEw6MyBdG6UUe-jBouQ',
    };

    final response = await client.post(
      Uri.parse(postUrl),
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully.');
      Components.showMessage("message sent successfully");
    } else {
      print('Notification sent failed.');
    }
  }
}
