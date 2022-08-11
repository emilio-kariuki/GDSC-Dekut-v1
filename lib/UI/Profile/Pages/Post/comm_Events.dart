// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Util/dimensions.dart';

class CommunityEvents extends StatefulWidget {
  const CommunityEvents({Key? key}) : super(key: key);

  @override
  State<CommunityEvents> createState() => _CommunityEventsState();
}

class _CommunityEventsState extends State<CommunityEvents> {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  final organizers = TextEditingController();
  final venue = TextEditingController();
  final link = TextEditingController();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          children: [
            InputField(
              showRequired: true,
              title: "Title",
              hint: "Enter the title of the event?",
              controller: title,
            ),
            InputField(
              showRequired: true,
              title: "Description",
              hint: "Enter the description of the event?",
              controller: description,
              maxLength: 100,
              linesCount: 3,
            ),
            InputField(
              showRequired: true,
              title: "Venue",
              hint: "Enter the venue of the event?",
              controller: venue,
            ),
            InputField(
              title: "Organizers",
              hint: "Enter the organizers of the event?",
              controller: organizers,
            ),
            InputField(
              showRequired: true,
              title: "Registration Link",
              hint: "Enter the link of the event?",
              controller: link,
            ),
            rowTimeAndEvent()
          ],
        ),
      )),
    );
  }

  Widget rowTimeAndEvent() {
    return Row(
      children: [
        Expanded(
          child: InputField(
            showRequired: true,
            title: "Start Time",
            hint: controller.selectTime.value,
            widget: IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: () async {
                String? token = await FirebaseMessaging.instance.getToken();
                print('token: $token');
                FocusScope.of(context).requestFocus(FocusNode());
                final TimeOfDay? result = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: false,
                        ),
                        child: child!,
                      );
                    });
                if (result != null) {
                  setState(() {
                    time = result;
                    print(
                        "The time schedules to end is : ${controller.selectTime.value}");
                    controller.selectTime.value = result.format(context);
                  });
                }
              },
            ),
          ),
        ),
        Components.spacerWidth(10),
        datePickStart(context)
      ],
    );
  }

  Widget datePickStart(BuildContext context) {
    return GetX<AppController>(
      builder: (controller) {
        return Expanded(
          child: InputField(
            showRequired: true,
            title: "Start Date",
            hint: controller.selectedDate.value,
            widget: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                ).then((date) {
                  setState(() {
                    controller.selectedDate.value =
                        DateFormat.yMMMd().format(date!);
                  });
                });
              },
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
