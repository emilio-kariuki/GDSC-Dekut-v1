import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Firebase_Logic/EventFirebase.dart';
import '../../../../Util/App_components.dart';
import '../../../../Util/dimensions.dart';
import '../../../Announcement/Model/announcement_model.dart';
import '../../../Events/Model/Event_model.dart';

class CommunityAnnoucements extends StatefulWidget {
  const CommunityAnnoucements({Key? key}) : super(key: key);

  @override
  State<CommunityAnnoucements> createState() => _CommunityAnnoucementsState();
}

class _CommunityAnnoucementsState extends State<CommunityAnnoucements> {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  File? image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                InputField(
                  showRequired: true,
                  title: "Title",
                  hint: "Enter the title of the announcement?",
                  controller: title,
                ),
                InputField(
                  showRequired: false,
                  title: "Link",
                  hint: "Enter the link of the annoucement?",
                  controller: link,

                ),
                InputField(
                  showRequired: true,
                  title: "Description",
                  hint: "Enter the description of the annoucement?",
                  controller: description,
                  maxLength: 80,
                  linesCount: 3,
                ),

                Components.spacerHeight(10),
                Row(
                  children: [
                    Components.header_3(
                        "Select Image",
                        controller.isDark.value
                            ? Colors.white
                            : Colors.black87),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () async {
                        await imageDialog();
                        await Components.uploadFile(image!);
                      },
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Components.spacerHeight(10),
                Components.button("Submit", () {
                  ActionFirebase.createAnnouncement(AnnouncementModel(
                    title.text,
                    description.text,
                    link.text ,
                    url,
                  ));
                  Get.back();
                  Components.showMessage("Data sent successfully");
                }, context)
              ],
            )),
      )),
    );
  }

  Future<void> getImage(ImageSource source) async {
    final image = await picker.pickImage(
        source: source, imageQuality: 90);
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
     FocusScope.of(context).requestFocus(FocusNode());
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
                  Get.back();
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
      onTap: ()  async {
          await getImage(source);
          Get.back();


      },
      leading: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
      title: GestureDetector(
        onTap: ()  async {
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
}
