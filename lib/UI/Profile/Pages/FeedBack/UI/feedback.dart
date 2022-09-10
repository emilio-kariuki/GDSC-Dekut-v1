import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Firebase_Logic/EventFirebase.dart';
import 'package:gdsc_app/UI/Profile/Pages/FeedBack/Model/feedback.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/main.dart';
import 'package:get/get.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: controller.isDark.value ? Colors.white : Colors.black,
              size: 18,
            ),
            backgroundColor:
                controller.isDark.value ? Colors.grey[900] : Colors.white,
            title: Components.header_3("FeedBack",
                controller.isDark.value ? Colors.white : Colors.black87),
            elevation: 0,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  InputField(
                    title: "Title",
                    hint: "Enter the title of your feedback",
                    controller: title,
                  ),
                  InputField(
                    title: "Description",
                    hint: "Enter the description of your feedback",
                    maxLength: 200,
                    linesCount: 5,
                    controller: description,
                  ),
                  Components.button("Send Feedback", () {
                    ActionFirebase.createFeedback(FeedBackModel(
                      description: description.text,
                    ));
                    flutterLocalNotificationsPlugin.show(
                        0,
                        "Feedback Sent",
                        "Your feedback is highly appreciatedd",
                        NotificationDetails(
                            android: AndroidNotificationDetails(
                          channel.id,
                          channel.name,
                          channelDescription: channel.description,
                          importance: Importance.low,
                          color: Colors.blue,
                          playSound: true,
                        )));
                  }, context)
                ],
              ),
            ),
          )),
        ));
  }
}
