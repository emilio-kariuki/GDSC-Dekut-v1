// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:gdsc_app/Firebase_Logic/EventFirebase.dart';
import 'package:gdsc_app/UI/Events/Model/Event_model.dart';
import 'package:gdsc_app/UI/Notification/pushNotification.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Util/dimensions.dart';

class CommunityEvents extends StatefulWidget {
  const CommunityEvents({Key? key}) : super(key: key);

  @override
  State<CommunityEvents> createState() => _CommunityEventsState();
}

class _CommunityEventsState extends State<CommunityEvents>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  final organizers = TextEditingController();
  final venue = TextEditingController();
  final link = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  File? image;
  final picker = ImagePicker();

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
              maxLength: 22,
            ),
            InputField(
              showRequired: true,
              title: "Description",
              hint: "Enter the description of the event?",
              controller: description,
              maxLength: 100,
              linesCount: 4,
            ),
            InputField(
              showRequired: true,
              title: "Venue",
              hint: "Enter the venue of the event?",
              controller: venue,
            ),
            Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Select image",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: controller.isDark.value
                      ? Colors.white
                      : Colors.black87,
                )),
            Components.spacerWidth(18),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 1,
                  ),
                ),
                  child: InkWell(
                    onTap: () async {
                      await imageDialog();
                      await Components.uploadFile(image!);
                    },
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color:
                          controller.isDark.value ? Colors.white : Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ],
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
            rowTimeAndEvent(),
            Components.spacerHeight(10),
            Components.spacerHeight(10),
            notificationCard(
                iconName: Icons.event,
                action: "Notify about the Event",
                widget: Switch(
                    // inactiveThumbColor: Colors.orangeAccent,
                    // activeColor: Colors.deepOrange,
                    // inactiveTrackColor: Colors.grey,
                    // activeTrackColor: controller.isDark.value ? Colors.white : const Color.fromARGB(255, 240, 173, 73),
                    trackColor: MaterialStateProperty.all(
                        controller.isDark.value
                            ? Colors.white
                            : Colors.black54),
                    thumbColor: MaterialStateProperty.all(Colors.deepOrange),
                    value: controller.isEventEnabled.value,
                    onChanged: ((value) {
                      controller.isEventEnabled.value = value;
                      print(value);
                      setState(() {});
                    }))),
            Components.button("Submit", () {
              FocusScope.of(context).requestFocus(FocusNode());
              ActionFirebase.createEvent(EventModel(
                  title.text,
                  description.text,
                  controller.selectedDate.value,
                  controller.selectTime.value,
                  venue.text,
                  link.text,
                  organizers.text,
                  url));
              Get.back();
              Components.createScaffoldMessanger(
                  "Data sent successfully", context);
              controller.isEventEnabled.value
                  ? FirebaseNotification.sendFirebaseNotification(
                      purpose: "Event",
                      title: title.text,
                    )
                  : null;
            }, context)
          ],
        ),
      )),
    );
  }

  Widget notificationCard(
      {required IconData iconName,
      required String action,
      required Widget widget}) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                iconName,
                size: 18,
                color: controller.isDark.value ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 15),
              Components.header_3(action,
                  controller.isDark.value ? Colors.white : Colors.black87),
            ],
          ),
          Expanded(child: Container()),
          widget
        ],
      ),
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
              color: controller.isDark.value ? Colors.white : Colors.black87,
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
                    controller.selectedDate.value =DateFormat.yMMMd().format(date ?? DateTime.now());
                  });
                });
              },
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 18,
                color: controller.isDark.value ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> getImage(ImageSource source) async {
    final image = await picker.pickImage(source: source, imageQuality: 90);
    try {
      if (image == null) return;

      final imageTempo = File(image.path);
      setState(() {
        this.image = imageTempo;
      });
    } on PlatformException catch (e) {
      Components.showMessage(
        "Failed to pick image $e",
      );
    }
  }

  Future<String?> imageDialog() async {
    final size = MediaQuery.of(context).size;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Container(
        width: size.width * 0.4,
        height: size.height * 0.16,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 14, 14, 20), width: 1),
          //border: Border.all(color: Color.fromARGB(255, 182, 36, 116),width:1 ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(5),
          title: const Text('choose image from: '),
          content: SingleChildScrollView(
            child: ListBody(children: [
              imageTile(ImageSource.camera, 'Camera', Icons.camera_alt),
              imageTile(ImageSource.gallery, "Gallery", Icons.photo_library),
              ListTile(
                selectedColor: Colors.grey,
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(Icons.cancel, color: Colors.black87),
                title: Text("Cancel",
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget imageTile(ImageSource source, String text, IconData icon) {
    return ListTile(
      selectedColor: Colors.grey,
      onTap: () async {
        await getImage(source);
        Get.back();
      },
      leading: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
      title: GestureDetector(
        onTap: () async {
          await getImage(source);
          Get.back();
        },
        child: Text(text,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }

  Widget iconImage() {
    return IconButton(
        onPressed: () {
          setState(() {
            imageDialog();
          });
        },
        icon: Icon(Icons.add_a_photo,
            size: 20,
            color: image != null
                ? Colors.white
                : const Color.fromARGB(255, 223, 152, 1)));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
