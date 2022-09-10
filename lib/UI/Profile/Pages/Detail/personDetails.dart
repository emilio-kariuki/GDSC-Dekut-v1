import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Firebase_Logic/UserFirebase.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/main.dart';
import 'package:get/get.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Util/App_components.dart';

class Persona extends StatefulWidget {
  const Persona({Key? key}) : super(key: key);

  @override
  State<Persona> createState() => _PersonaState();
}

class _PersonaState extends State<Persona> {
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          //leading: const Icon(Icons.home, size: 20,color: Colors.black87,),
          iconTheme: IconThemeData(
              color: controller.isDark.value ? Colors.white : Colors.grey[900],
              size: 20),
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          title: Components.header_3("Profile Details",
              controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.height * 0.13,
                      fit: BoxFit.cover,
                      imageUrl: urlDetails == 'empty'
                          ? Constants.announceLogo
                          : urlDetails!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  strokeWidth: 1,
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Components.spacerWidth(20),
                  Components.header_3("Change Image",
                      controller.isDark.value ? Colors.white : Colors.black87),
                  Components.spacerWidth(20),
                  InkWell(
                      onTap: () async {
                        await Components.imageDialog(context);

                        await Components.uploadFileDetails(
                            controller.image.value);
                      },
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 20,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.grey[900],
                      )),
                ],
              ),
              InputField(
                title: "Name",
                hint: "Name",
                controller: nameDetails,
              ),
              InputField(
                title: "Email",
                hint: "Email",
                controller: emailDetails,
              ),
              InputField(
                title: "Phone starting with 7...",
                hint: "phone",
                controller: phoneDetails,
              ),
              InputField(
                title: "Github",
                hint: "Github Username",
                controller: githubDetails,
              ),
              InputField(
                title: "Linkedin",
                hint: "Linkedin Username",
                controller: linkedinDetails,
              ),
              InputField(
                title: "Twitter",
                hint: "Twitter Username",
                controller: twitterDetails,
              ),
              InputField(
                title: "Stack",
                hint: "Stack",
                controller: technologyDetails,
              ),
              Components.button("Update", () async {
                await firestoreInstance.collection("users").doc(userID).update({
                  "username": nameDetails.text,
                  "email": emailDetails.text,
                  "phone": phoneDetails.text,
                  "github": githubDetails.text,
                  "linkedin": linkedinDetails.text,
                  "twitter": twitterDetails.text,
                  "userID": userID,
                  "technology": technologyDetails.text,
                  "imageUrl": urlDetails == 'empty'
                      ? Constants.announceLogo
                      : urlDetails!,
                }).then((value) async {
                  Components.createScaffoldMessanger("Data Updated successfully", context);
                  controller.getTechology();
                  controller.getProfileImage();
                  controller.getProfileDetails();
                }).catchError((error) {
                  print("The error is $error");
                  Components.showMessage("Failed to update");
                  print(error);
                });
                Get.back();
                Get.back();
              }, context)
            ]),
          ),
        )),
      ),
    );
  }
}
