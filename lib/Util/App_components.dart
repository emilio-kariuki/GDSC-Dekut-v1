// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable, avoid_print, use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Firebase_Logic/EventFirebase.dart';
import 'package:gdsc_app/Firebase_Logic/UserFirebase.dart';
import 'package:gdsc_app/UI/Events/UI/Events.dart';
import 'package:gdsc_app/UI/Profile/Pages/Admins/Admins.dart';

import 'package:gdsc_app/UI/Profile/Pages/Post/Post.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import '../main.dart';

String? url;
File? image;
String? profileUrl;
String? stack;
final title = TextEditingController();
final description = TextEditingController();
final name = TextEditingController();
final role = TextEditingController();
final venue = TextEditingController();
final link = TextEditingController();
final organizers = TextEditingController();
final phone = TextEditingController();
final email = TextEditingController();
int i = 0;

//Leads
final nameLead = TextEditingController();
final roleLead = TextEditingController();
final phoneLead = TextEditingController();
final emailLead = TextEditingController();
String? urlLead;

//Resources
final titleResource = TextEditingController();
final descriptionResource = TextEditingController();
final linkResource = TextEditingController();
String? urlResource;

//Announcements
final titleAnnouncement = TextEditingController();
final descriptionAnnouncement = TextEditingController();
String? urlAnnouncement;

//Events
final titleEvent = TextEditingController();
final descriptionEvent = TextEditingController();
final venueEvent = TextEditingController();
final linkEvent = TextEditingController();
final organizersEvent = TextEditingController();

String? urlEvent;

//Meeting
final titleMeeting = TextEditingController();
final descriptionMeeting = TextEditingController();
final linkMeeting = TextEditingController();
final organizersMeeting = TextEditingController();
String? urlMeeting;

class Components {
  static File? image;
  static var controller = Get.put(AppController());
  static var myGroup = AutoSizeGroup();
  static double sizeHeight = Get.mediaQuery.size.height;
  static double sizeWidth = Get.mediaQuery.size.width;
  static Widget header_1(String text) {
    return AutoSizeText(
      text,
      maxLines: 1,
      maxFontSize: 30,
      minFontSize: 30,
      group: myGroup,
      style: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget header_2(String text) {
    return AutoSizeText(
      text,
      maxLines: 1,
      maxFontSize: 24,
      minFontSize: 20,
      group: myGroup,
      style: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget header_3(String text, Color color) {
    return AutoSizeText(
      text,
      maxLines: 1,
      maxFontSize: 16,
      minFontSize: 12,
      textAlign: TextAlign.start,
      group: myGroup,
      style: GoogleFonts.quicksand(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget header_4(String text, Color color) {
    return AutoSizeText(
      text,
      maxLines: 20,
      maxFontSize: 12,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      minFontSize: 10,
      textAlign: TextAlign.start,
      group: myGroup,
      style: GoogleFonts.quicksand(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget showDividerLine() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      height: Dimensions.PADDING_SIZE_SMALL,
    );
  }

  static Widget spacerWidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget spacerHeight(double height) {
    return SizedBox(
      height: height,
    );
  }

  static Widget avatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        height: 90,
        width: 50,
        fit: BoxFit.cover,
        imageUrl: profileUrl ?? Constants.defaultIcon,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
                strokeWidth: 1, value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  static Widget personalInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          avatar(),
          const SizedBox(width: 15),
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  header_3(userName,
                      controller.isDark.value ? Colors.white : Colors.black87),
                  header_3(userEmail,
                      controller.isDark.value ? Colors.white : Colors.black54),
                  header_3(controller.stack.value,
                      controller.isDark.value ? Colors.white : Colors.black54)
                ],
              )),
        ],
      ),
    );
  }

  static Widget showLogOutButton(
      String text, Function() onPressed, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.075,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.deepOrange,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                Text(text,
                    style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget accountText(String text_1, String text_2, Function() function) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          header_3(
              text_1, controller.isDark.value ? Colors.white : Colors.black87),
          InkWell(onTap: function, child: header_3(text_2, Colors.green))
        ],
      ),
    );
  }

  static Widget cardButton(
      IconData iconName, String action, Function() function) {
    return InkWell(
      onTap: function,
      child: SizedBox(
        width: double.infinity,
        height: sizeHeight * 0.06,
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  iconName,
                  size: 18,
                  color:
                      controller.isDark.value ? Colors.white : Colors.black87,
                ),
                const SizedBox(width: 15),
                header_3(action,
                    controller.isDark.value ? Colors.white : Colors.black87),
              ],
            ),
            Expanded(child: Container()),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: controller.isDark.value ? Colors.white : Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  static Widget button(
      String text, Function() onPressed, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          vertical: Dimensions.PADDING_SIZE_OVER_LARGE),
      child: SizedBox(
        height: size.height * 0.075,
        width: size.width * 0.75,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.CONTAINER_SIZE_SMALL),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
          ),
          child: Text(text,
              style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  static showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 0, 188, 25),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget showDivider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_SMALL),
            child: Divider(
              thickness: 0.5,
              height: Dimensions.CONTAINER_SIZE_OVER_LARGE,
              color: controller.isDark.value ? Colors.white : Colors.black87,
            ),
          )),
          Text("OR",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color:
                      controller.isDark.value ? Colors.white : Colors.black87)),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_SMALL),
            child: Divider(
              thickness: 0.5,
              height: Dimensions.CONTAINER_SIZE_LARGE,
              color: controller.isDark.value ? Colors.white : Colors.black87,
            ),
          )),
        ],
      ),
    );
  }

  static Widget signInWith(String imageUrl, Function() function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: Dimensions.CONTAINER_SIZE_LARGE,
        width: Dimensions.CONTAINER_SIZE_LARGE,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        child: SvgPicture.asset(
          imageUrl,
          width: Dimensions.CONTAINER_SIZE_LARGE,
          height: Dimensions.CONTAINER_SIZE_LARGE,
          color: Colors.black,
        ),
      ),
    );
  }

  static Widget showImage(String imageName, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(2),
        height: size.height * 0.2,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(
              imageName,
            ).image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  static Future<String?> uploadFileLead(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(image.path);
      Reference ref = storage.ref().child("EcoVille/$filename");

      if (controller.isSent.value == false) {
        Get.defaultDialog(
            title: "Uploading image...",
            //middleTextStyle: TextAlign.center,
            middleTextStyle: GoogleFonts.quicksand(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            content: const CircularProgressIndicator());
        await ref.putFile(image);
        urlLead = await ref.getDownloadURL();
        controller.isSent.value = false;

        Get.back();
      }

      controller.isSent.value = false;
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadFileMeeting(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(image.path);
      Reference ref = storage.ref().child("EcoVille/$filename");

      if (controller.isSent.value == false) {
        Get.defaultDialog(
            title: "Uploading image...",
            //middleTextStyle: TextAlign.center,
            middleTextStyle: GoogleFonts.quicksand(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            content: const CircularProgressIndicator());
        await ref.putFile(image);
        urlMeeting = await ref.getDownloadURL();
        controller.isSent.value = false;

        Get.back();
      }

      controller.isSent.value = false;
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadFileResource(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(image.path);
      Reference ref = storage.ref().child("EcoVille/$filename");

      if (controller.isSent.value == false) {
        Get.defaultDialog(
            title: "Uploading image...",
            //middleTextStyle: TextAlign.center,
            middleTextStyle: GoogleFonts.quicksand(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            content: const CircularProgressIndicator());
        await ref.putFile(image);
        urlResource = await ref.getDownloadURL();
        controller.isSent.value = false;

        Get.back();
      }

      controller.isSent.value = false;
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadFileAnnouncement(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(image.path);
      Reference ref = storage.ref().child("EcoVille/$filename");

      if (controller.isSent.value == false) {
        Get.defaultDialog(
            title: "Uploading image...",
            //middleTextStyle: TextAlign.center,
            middleTextStyle: GoogleFonts.quicksand(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            content: const CircularProgressIndicator());
        await ref.putFile(image);
        urlAnnouncement = await ref.getDownloadURL();
        controller.isSent.value = false;

        Get.back();
      }

      controller.isSent.value = false;
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadFileEvent(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(image.path);
      Reference ref = storage.ref().child("EcoVille/$filename");

      if (controller.isSent.value == false) {
        Get.defaultDialog(
            title: "Uploading image...",
            //middleTextStyle: TextAlign.center,
            middleTextStyle: GoogleFonts.quicksand(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            content: const CircularProgressIndicator());
        await ref.putFile(image);
        urlEvent = await ref.getDownloadURL();
        controller.isSent.value = false;

        Get.back();
      }

      controller.isSent.value = false;
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadFile(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(image.path);
      Reference ref = storage.ref().child("EcoVille/$filename");

      if (controller.isSent.value == false) {
        Get.defaultDialog(
            title: "Uploading image...",
            //middleTextStyle: TextAlign.center,
            middleTextStyle: GoogleFonts.quicksand(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            content: const CircularProgressIndicator());
        await ref.putFile(image);
        url = await ref.getDownloadURL();
        controller.isSent.value = false;

        Get.back();
      }

      controller.isSent.value = false;
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }

  static Widget adminLeadsListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('leads').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return spacerHeight(10);
                },
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: data['imageUrl'] ?? Constants.announceLogo,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    strokeWidth: 1,
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      data['name'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['role'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: InkWell(
                      onTap: () {
                        nameLead.text = data['name'];
                        roleLead.text = data['role'];
                        emailLead.text = data['email'];
                        phoneLead.text = data['phone'];
                        urlLead = data['imageUrl'];
                        Components.adminLeadBottomSheet(
                            docs[index].id, context);
                      },
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget leadListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('leads').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return spacerHeight(10);
                },
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: true,
                              barrierDismissible: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return Scaffold(
                                  backgroundColor: controller.isDark.value
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  body: SafeArea(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon:
                                                const Icon(Icons.cancel_sharp),
                                            color: controller.isDark.value
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        Expanded(
                                          child: InteractiveViewer(
                                            scaleEnabled: true,
                                            panEnabled: true,
                                            child: Hero(
                                              tag: docs[index].id,
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  //height: 300,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.fill,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  imageUrl: data['imageUrl'] ??
                                                      Constants.announceLogo,
                                                  // placeholder: (context, url) =>
                                                  //     const CupertinoActivityIndicator(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Hero(
                          tag: docs[index].id,
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl:
                                data['imageUrl'] ?? Constants.announceLogo,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        strokeWidth: 1,
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data['name'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['role'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: InkWell(
                      onTap: () => Components.showLeadContact(
                          data['phone'], data['email']),
                      child: Icon(
                        Icons.phone,
                        size: 20,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget adminResourceListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('resources').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return spacerHeight(10);
                },
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: data['imageUrl'] ?? Constants.announceLogo,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    strokeWidth: 1,
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: InkWell(
                      onTap: () {
                        titleResource.text = data['title'];
                        descriptionResource.text = data['description'];
                        linkResource.text = data['link'];
                        urlResource = data['imageUrl'];
                        Components.adminResourcesBottomSheet(
                            docs[index].id, context);
                      },
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget resourceListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('resources').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: showDividerLine(),
                  );
                },
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    onTap: () async {
                      String url = data['link'];
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launch(url,
                            forceWebView: true,
                            enableJavaScript: true,
                            enableDomStorage: true,
                            forceSafariVC: false);
                      } else {
                        showMessage("Cannot launch url");
                        throw 'Could not launch $url';
                      }
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: true,
                              barrierDismissible: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return Scaffold(
                                  backgroundColor: controller.isDark.value
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  body: SafeArea(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon:
                                                const Icon(Icons.cancel_sharp),
                                            color: controller.isDark.value
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        Expanded(
                                          child: InteractiveViewer(
                                            scaleEnabled: true,
                                            panEnabled: true,
                                            child: Hero(
                                              tag: docs[index].id,
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  //height: 300,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.fill,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  imageUrl: data['imageUrl'] ??
                                                      Constants.announceLogo,
                                                  // placeholder: (context, url) =>
                                                  //     const CupertinoActivityIndicator(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Hero(
                          tag: docs[index].id,
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl:
                                data['imageUrl'] ?? Constants.announceLogo,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        strokeWidth: 1,
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: Icon(
                      Icons.link,
                      size: 20,
                      color: controller.isDark.value
                          ? Colors.white
                          : Colors.black87,
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget adminAnnouncementListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('announcements').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: docs?.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs![index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: data['imageUrl'] ?? Constants.announceLogo,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    strokeWidth: 1,
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: InkWell(
                      onTap: () {
                        titleAnnouncement.text = data['title'];
                        descriptionAnnouncement.text = data['description'];
                        urlAnnouncement = data['imageUrl'];
                        Components.adminAnnouncementBottomSheet(
                            docs[index].id, context);
                      },
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget announcementListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('announcements').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: data['imageUrl'],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    strokeWidth: 1,
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    // trailing: Text(data['date'],
                    //     style: TextStyle(
                    //       color: controller.isDark.value
                    //           ? Colors.white
                    //           : Colors.black87,
                    //     )),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget adminEventListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('events').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return spacerHeight(10);
                },
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        onTap: () {},
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          imageUrl: data['imageUrl'] ?? Constants.announceLogo,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      strokeWidth: 1,
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: InkWell(
                      onTap: () {
                        titleEvent.text = data['title'];
                        descriptionEvent.text = data['description'];
                        urlEvent = data['imageUrl'];
                        venueEvent.text = data['venue'];
                        controller.selectTime.value = data['time'];
                        controller.selectedDate.value = data['date'];
                        organizersEvent.text = data['organizers'];
                        linkEvent.text = data['link'];
                        Components.adminEventBottomSheet(
                            docs[index].id, context);
                      },
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget eventListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('events').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                reverse: false,
                dragStartBehavior: DragStartBehavior.start,
                shrinkWrap: true,
                itemCount: docs?.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs![index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: true,
                              barrierDismissible: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return Scaffold(
                                  backgroundColor: controller.isDark.value
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  body: SafeArea(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon:
                                                const Icon(Icons.cancel_sharp),
                                            color: controller.isDark.value
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        Expanded(
                                          child: InteractiveViewer(
                                            scaleEnabled: true,
                                            panEnabled: true,
                                            child: Hero(
                                              tag: docs[index].id,
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  //height: 40,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.fill,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  imageUrl: data['imageUrl'] ??
                                                      Constants.announceLogo,
                                                  // placeholder: (context, url) =>
                                                  //     const CupertinoActivityIndicator(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Hero(
                          tag: docs[index].id,
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl: data['imageUrl'],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        strokeWidth: 1,
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['venue'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: Text(data['date'],
                        style: TextStyle(
                          color: controller.isDark.value
                              ? Colors.white
                              : Colors.black87,
                        )),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget adminMeetingListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('meetings').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return spacerHeight(10);
                },
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        onTap: () {},
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          imageUrl: data['imageUrl'] ?? Constants.announceLogo,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      strokeWidth: 1,
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: InkWell(
                      onTap: () {
                        titleMeeting.text = data['title'];
                        descriptionMeeting.text = data['description'];
                        urlMeeting = data['imageUrl'];
                        controller.selectTime.value = data['time'];
                        controller.selectedDate.value = data['date'];
                        organizersMeeting.text = data['organizers'];
                        linkMeeting.text = data['link'];
                        Components.adminMeetingBottomSheet(
                            docs[index].id, context);
                      },
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget meetingListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('meetings').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;

              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: showDividerLine(),
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                reverse: false,
                dragStartBehavior: DragStartBehavior.start,
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: true,
                              barrierDismissible: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return Scaffold(
                                  backgroundColor: controller.isDark.value
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  body: SafeArea(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon:
                                                const Icon(Icons.cancel_sharp),
                                            color: controller.isDark.value
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        Expanded(
                                          child: InteractiveViewer(
                                            scaleEnabled: true,
                                            panEnabled: true,
                                            child: Hero(
                                              tag: docs[index].id,
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  //height: 40,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.fill,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  imageUrl: data['imageUrl'] ??
                                                      Constants.announceLogo,
                                                  // placeholder: (context, url) =>
                                                  //     const CupertinoActivityIndicator(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Hero(
                          tag: docs[index].id,
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl: data['imageUrl'],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        strokeWidth: 1,
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Text(data['description'],
                        style: TextStyle(
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87)),
                    trailing: Text(data['date'],
                        style: TextStyle(
                          color: controller.isDark.value
                              ? Colors.white
                              : Colors.black87,
                        )),
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static confirmAdminPost(password) {
    Get.defaultDialog(
      //titlePadding: EdgeInsets.only(top: 5),
      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      cancelTextColor: controller.isDark.value ? Colors.white : Colors.black87,
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      title: Constants.confirmAdmin,
      content: InputField(
          title: "Enter the password",
          hint: "Enter password",
          controller: password),
      titleStyle: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      onCancel: (() => Get.back()),
      onConfirm: () {
        if (password.text.isEmpty) {
          showMessage("Enter password");
        } else if (password.text == Constants.adminPassword) {
          Get.back();
          Get.to(() => const Post());
        } else {
          showMessage("Incorrect password");
          Get.back();
        }
      },
    );
  }

  static confirmAdmin(password) {
    Get.defaultDialog(
      //titlePadding: EdgeInsets.only(top: 5),
      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      cancelTextColor: controller.isDark.value ? Colors.white : Colors.black87,
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      title: Constants.confirmAdmin,
      content: InputField(
          title: "Enter the password",
          hint: "Enter password",
          controller: password),
      titleStyle: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      onCancel: (() => Get.back()),
      onConfirm: () {
        if (password.text.isEmpty) {
          showMessage("Enter password");
        } else if (password.text == Constants.adminPassword) {
          Get.back();
          Get.to(() => const Admin(),
              duration: const Duration(milliseconds: 100));
        } else {
          showMessage("Incorrect password");
          Get.back();
        }
      },
    );
  }

  static adminResourcesBottomSheet(String id, BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.bottomSheet(
      elevation: 0,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      Container(
          height: size.height * 0.13,
          color: controller.isDark.value ? Colors.grey[900] : Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: button("Edit", () async {
                Get.back();
                await editResources(id, context);
              }, context)),
              Expanded(
                  child: button("Delete", () {
                ActionFirebase.deleteDoc(id, 'resources');
                Get.back();
              }, context))
            ],
          )),
      //barrierColor: Colors.red[50],
      isDismissible: true,
    );
  }

  static adminEventBottomSheet(String id, BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.bottomSheet(
      elevation: 0,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      Container(
          height: size.height * 0.13,
          color: controller.isDark.value ? Colors.grey[900] : Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: button("Edit", () async {
                Get.back();
                await editEvent(id, context);
              }, context)),
              Expanded(
                  child: button("Delete", () {
                ActionFirebase.deleteDoc(id, 'events');
                Get.back();
              }, context))
            ],
          )),
      //barrierColor: Colors.red[50],
      isDismissible: true,
    );
  }

  static adminMeetingBottomSheet(String id, BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.bottomSheet(
      elevation: 0,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      Container(
          height: size.height * 0.13,
          color: controller.isDark.value ? Colors.grey[900] : Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: button("Edit", () async {
                Get.back();
                await editMeeting(id, context);
              }, context)),
              Expanded(
                  child: button("Delete", () {
                ActionFirebase.deleteDoc(id, 'meetings');
                Get.back();
              }, context))
            ],
          )),
      //barrierColor: Colors.red[50],
      isDismissible: true,
    );
  }

  static adminLeadBottomSheet(String id, BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.bottomSheet(
      elevation: 0,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      Container(
          height: size.height * 0.13,
          color: controller.isDark.value ? Colors.grey[900] : Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: button("Edit", () async {
                Get.back();
                await editLeads(id, context);
              }, context)),
              Expanded(
                  child: button("Delete", () {
                ActionFirebase.deleteDoc(id, 'leads');
                Get.back();
              }, context))
            ],
          )),
      //barrierColor: Colors.red[50],
      isDismissible: true,
    );
  }

  static adminAnnouncementBottomSheet(String id, BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.bottomSheet(
      elevation: 0,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      Container(
          height: size.height * 0.13,
          color: controller.isDark.value ? Colors.grey[900] : Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: button("Edit", () async {
                Get.back();
                await editAnnouncement(id, context);
              }, context)),
              Expanded(
                  child: button("Delete", () {
                ActionFirebase.deleteDoc(id, 'announcements');
                Get.back();
              }, context))
            ],
          )),
      //barrierColor: Colors.red[50],
      isDismissible: true,
    );
  }

  static editLeads(String id, BuildContext context) {
    Get.defaultDialog(
      //titlePadding: EdgeInsets.only(top: 5),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      cancelTextColor: controller.isDark.value ? Colors.white : Colors.black87,
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      title: "Edit Lead Details",
      content: Column(
        children: [
          InputField(
            showRequired: true,
            title: "Name",
            hint: "Enter the name of the lead?",
            controller: nameLead,
          ),
          InputField(
            showRequired: true,
            title: "Role",
            hint: "Enter the role of the lead?",
            controller: roleLead,
          ),
          Components.spacerHeight(5),
          Row(
            children: [
              Components.header_3("Select Image",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(child: Container()),
              InkWell(
                onTap: () async {
                  await imageDialog(context);
                  await Components.uploadFileLead(image!);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color:
                      controller.isDark.value ? Colors.white : Colors.black87,
                  size: 20,
                ),
              ),
            ],
          ),
          InputField(
            showRequired: true,
            title: "Phone",
            hint: "Enter the phone number of the lead?",
            controller: phoneLead,
          ),
          InputField(
            showRequired: true,
            title: "Email",
            hint: "Enter the email of the lead?",
            controller: emailLead,
          ),
        ],
      ),
      titleStyle: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      onCancel: (() => Get.back()),
      onConfirm: () async {
        await firestoreInstance.collection("leads").doc(id).update({
          "name": nameLead.text,
          "role": roleLead.text,
          "phone": phoneLead.text,
          "email": emailLead.text,
          "imageUrl": url ?? urlLead,
        }).then((value) {
          Components.showMessage("Data Updated successfully");
        }).catchError((error) {
          Components.showMessage("Failed to update");
        });
        Get.back();
      },
    );
  }

  static showLeadContact(String phone, String email) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      cancelTextColor: controller.isDark.value ? Colors.white : Colors.black87,
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      title: "Lead Contact",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              header_3("Phone : ",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: (() async {
                  String url = "tel:$phone";
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
                child: header_3(phone,
                    controller.isDark.value ? Colors.white : Colors.black87),
              )
            ],
          ),
          spacerHeight(10),
          Row(
            children: [
              header_3("Email : ",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(
                child: Container(),
              ),
              InkWell(
                  onTap: () async {
                    String url = "mailto:$email";
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: header_3(email,
                      controller.isDark.value ? Colors.white : Colors.black87)),
            ],
          ),
          spacerHeight(10),
          Row(
            children: [
              header_3("WhatsApp : ",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(
                child: Container(),
              ),
              InkWell(
                  onTap: () async => await launch('https://wa.me/$phone'),
                  child: header_3(phone,
                      controller.isDark.value ? Colors.white : Colors.black87)),
            ],
          ),
          spacerHeight(10),
          Row(
            children: [
              header_3("Sms : ",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(
                child: Container(),
              ),
              InkWell(
                  onTap: () async => await launch("sms:$phone"),
                  child: header_3(phone,
                      controller.isDark.value ? Colors.white : Colors.black87)),
            ],
          ),
        ],
      ),
      titleStyle: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static editAnnouncement(String id, BuildContext context) {
    Get.defaultDialog(
      //titlePadding: EdgeInsets.only(top: 5),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      cancelTextColor: controller.isDark.value ? Colors.white : Colors.black87,
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      title: "Edit an Announcement",
      content: Column(
        children: [
          InputField(
            showRequired: true,
            title: "Title",
            hint: "Enter the title of the announcement?",
            controller: titleAnnouncement,
          ),
          InputField(
            showRequired: true,
            title: "Description",
            hint: "Enter the description of the annoucement?",
            controller: descriptionAnnouncement,
            maxLength: 80,
            linesCount: 3,
          ),
          Components.spacerHeight(10),
          Row(
            children: [
              Components.header_3("Select Image",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(child: Container()),
              InkWell(
                onTap: () async {
                  await imageDialog(context);
                  await Components.uploadFileAnnouncement(image!);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color:
                      controller.isDark.value ? Colors.white : Colors.black87,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      titleStyle: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      onCancel: (() => Get.back()),
      onConfirm: () async {
        await firestoreInstance.collection("announcements").doc(id).update({
          "title": title.text,
          "description": description.text,
          "imageUrl": url ?? urlAnnouncement,
        }).then((value) {
          Components.showMessage("Data Updated successfully");
        }).catchError((error) {
          Components.showMessage("Failed to update");
        });
        Get.back();
      },
    );
  }

  static editResources(String id, BuildContext context) {
    Get.defaultDialog(
      //titlePadding: EdgeInsets.only(top: 5),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      cancelTextColor: controller.isDark.value ? Colors.white : Colors.black87,
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      title: "Edit a resource",
      content: Column(
        children: [
          InputField(
            showRequired: true,
            title: "Title",
            hint: "Enter the title of the resource?",
            controller: titleResource,
          ),
          InputField(
            showRequired: true,
            title: "Link",
            hint: "Enter the link of the resource",
            controller: linkResource,
          ),
          InputField(
            showRequired: true,
            title: "Description",
            hint: "Enter the description of the resource?",
            controller: descriptionResource,
            maxLength: 80,
            linesCount: 3,
          ),
          Row(
            children: [
              Components.header_3("Select Image",
                  controller.isDark.value ? Colors.white : Colors.black87),
              Expanded(child: Container()),
              InkWell(
                onTap: () async {
                  await imageDialog(context);
                  await Components.uploadFileResource(image!);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color:
                      controller.isDark.value ? Colors.white : Colors.black87,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      titleStyle: GoogleFonts.quicksand(
        color: controller.isDark.value ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      onCancel: (() => Get.back()),
      onConfirm: () async {
        await firestoreInstance.collection("resources").doc(id).update({
          "title": titleResource.text,
          "link": linkResource.text,
          "description": descriptionResource.text,
          "imageUrl": url ?? urlResource,
        }).then((value) {
          Components.showMessage("Data Updated successfully");
        }).catchError((error) {
          Components.showMessage("Failed to update");
        });
        Get.back();
      },
    );
  }

  static editMeeting(String id, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //titlePadding: EdgeInsets.only(top: 5),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),

            backgroundColor:
                controller.isDark.value ? Colors.grey[900] : Colors.white,
            titleTextStyle: GoogleFonts.quicksand(
              color: controller.isDark.value ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            title: Text("Edit a Meeting"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                    showRequired: true,
                    title: "Title",
                    hint: "Enter the title of the meeting?",
                    controller: titleMeeting,
                  ),
                  InputField(
                    showRequired: true,
                    title: "Description",
                    hint: "Enter the description of the meeting?",
                    controller: descriptionMeeting,
                    maxLength: 80,
                    linesCount: 3,
                  ),
                  Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
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
                          await imageDialog(context);
                          await Components.uploadFileMeeting(image!);
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
                  InputField(
                    title: "Organizers",
                    hint: "Enter the organizers of the event?",
                    controller: organizersMeeting,
                  ),
                  InputField(
                    showRequired: true,
                    title: "Registration Link",
                    hint: "Enter the link of the event?",
                    controller: linkMeeting,
                  ),
                  rowTimeAndEvent(context),
                  Row(
                    children: [
                      Expanded(
                          child: button("Exit", () async {
                        Get.back();
                      }, context)),
                      Expanded(
                          child: button("Ok", () async {
                        await firestoreInstance
                            .collection("meetings")
                            .doc(id)
                            .update({
                          "title": titleMeeting.text,
                          "description": descriptionMeeting.text,
                          "organizers": organizersMeeting.text,
                          "link": linkMeeting.text,
                          "date": controller.selectedDate.value,
                          "time": controller.selectTime.value,
                          "imageUrl": urlMeeting,
                        }).then((value) {
                          Components.showMessage("Data Updated successfully");
                        }).catchError((error) {
                          Components.showMessage("Failed to update");
                        });
                        Get.back();
                        Get.back();
                      }, context))
                    ],
                  ),
                ],
              ),
            ),
            scrollable: true,
          );
        });
  }

  static editEvent(String id, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //titlePadding: EdgeInsets.only(top: 5),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),

            backgroundColor:
                controller.isDark.value ? Colors.grey[900] : Colors.white,
            titleTextStyle: GoogleFonts.quicksand(
              color: controller.isDark.value ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            title: Text("Edit and Event"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                    showRequired: true,
                    title: "Title",
                    hint: "Enter the title of the event?",
                    controller: titleEvent,
                  ),
                  InputField(
                    showRequired: true,
                    title: "Description",
                    hint: "Enter the description of the event?",
                    controller: descriptionEvent,
                    maxLength: 80,
                    linesCount: 3,
                  ),
                  InputField(
                    showRequired: true,
                    title: "Venue",
                    hint: "Enter the venue of the event?",
                    controller: venueEvent,
                  ),
                  Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
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
                          await imageDialog(context);
                          await Components.uploadFileEvent(image!);
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
                  InputField(
                    title: "Organizers",
                    hint: "Enter the organizers of the event?",
                    controller: organizersEvent,
                  ),
                  InputField(
                    showRequired: true,
                    title: "Registration Link",
                    hint: "Enter the link of the event?",
                    controller: linkEvent,
                  ),
                  rowTimeAndEvent(context),
                  Row(
                    children: [
                      Expanded(
                          child: button("Exit", () async {
                        Get.back();
                      }, context)),
                      Expanded(
                          child: button("Ok", () async {
                        await firestoreInstance
                            .collection("events")
                            .doc(id)
                            .update({
                          "title": titleEvent.text,
                          "description": descriptionEvent.text,
                          "venue": venueEvent.text,
                          "organizers": organizersEvent.text,
                          "link": linkEvent.text,
                          "date": controller.selectedDate.value,
                          "time": controller.selectTime.value,
                          "imageUrl": urlEvent,
                        }).then((value) {
                          Components.showMessage("Data Updated successfully");
                        }).catchError((error) {
                          Components.showMessage("Failed to update");
                        });
                        Get.back();
                        Get.back();
                      }, context))
                    ],
                  ),
                ],
              ),
            ),
            scrollable: true,
          );
        });
  }

  static Widget rowTimeAndEvent(BuildContext context) {
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
                  controller.time.value = result;
                  print(
                      "The time schedules to end is : ${controller.selectTime.value}");
                  controller.selectTime.value = result.format(context);
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

  static Widget datePickStart(BuildContext context) {
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
                  controller.selectedDate.value =
                      DateFormat.yMMMd().format(date!);
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

  static Future<String?> imageDialog(BuildContext context) async {
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
              imageTile(
                  ImageSource.camera, 'Camera', Icons.camera_alt, context),
              imageTile(
                  ImageSource.gallery, "Gallery", Icons.photo_library, context),
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

  static Widget imageTile(
      ImageSource source, String text, IconData icon, BuildContext context) {
    return ListTile(
      selectedColor: Colors.grey,
      onTap: () async {
        await controller.getImage(source);
        Get.back();
        await Components.uploadFile(
          controller.image.value,
        );
        controller.update();
      },
      leading: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
      title: GestureDetector(
        onTap: () async {
          await controller.getImage(source);
          Get.back();
          await Components.uploadFile(controller.image.value);
          (context as Element).markNeedsBuild();
        },
        child: Text(text,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }

  static Widget eventListSlider(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('events').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              controller.docsLength.value = docs!.length;
              itemCount = controller.docsLength.value;

              return CarouselSlider.builder(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.2,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    autoPlay: true,
                    //enlargeCenterPage: true,
                    onPageChanged: (int i, carouselPageChangedReason) {
                      controller.i.value = i.toDouble();
                      controller.update();
                    }),
                itemCount: docs.length,
                itemBuilder: (context, index, realIndex) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            height: MediaQuery.of(context).size.height * 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: controller.isDark.value
                                                ? Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Colors.black87,
                                            width: 1,
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                opaque: true,
                                                barrierDismissible: false,
                                                pageBuilder:
                                                    (BuildContext context, _,
                                                        __) {
                                                  return Scaffold(
                                                    backgroundColor:
                                                        controller.isDark.value
                                                            ? Colors.grey[900]
                                                            : Colors.white,
                                                    body: SafeArea(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: IconButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              icon: const Icon(Icons
                                                                  .cancel_sharp),
                                                              color: controller
                                                                      .isDark
                                                                      .value
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black87,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                InteractiveViewer(
                                                              scaleEnabled:
                                                                  true,
                                                              panEnabled: true,
                                                              child: Hero(
                                                                tag: docs[index]
                                                                    .id,
                                                                child: Center(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    //height: 40,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                    imageUrl: data[
                                                                            'imageUrl'] ??
                                                                        Constants
                                                                            .announceLogo,
                                                                    // placeholder: (context, url) =>
                                                                    //     const CupertinoActivityIndicator(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: docs[index].id,
                                            child: CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              fit: BoxFit.cover,
                                              imageUrl: data['imageUrl'] ??
                                                  Constants.announceLogo,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    spacerWidth(15),
                                    // RotatedBox(
                                    //   quarterTurns: 2,
                                    //   child: Container(
                                    //     height:
                                    //         MediaQuery.of(context).size.height * 0.12,
                                    //     width: 1,
                                    //     decoration: BoxDecoration(
                                    //       color: controller.isDark.value
                                    //           ? Colors.white
                                    //           : Color.fromARGB(255, 255, 0, 0)
                                    //               .withOpacity(0.7),
                                    //     ),
                                    //   ),
                                    // ),
                                    spacerWidth(5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //spacerHeight(3),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.title,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Title: ${data['title']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Date : ${data['date']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Time : ${data['time']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Venue : ${data['venue']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.desktop_windows_outlined,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Organizer : ${data['organizers']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                spacerHeight(10),
                                header_4(
                                    "Description : ${data['description']}",
                                    controller.isDark.value
                                        ? Colors.white
                                        : Colors.black87),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          right: 15,
                          child: Icon(Icons.link,
                              size: 20, color: Colors.deepOrange)),
                    ],
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget meetingListSlider(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('meetings').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;
              controller.docsLength.value = docs!.length;
              itemCount = controller.docsLength.value;

              return CarouselSlider.builder(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.2,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    autoPlay: true,
                    //enlargeCenterPage: true,
                    onPageChanged: (int i, carouselPageChangedReason) {
                      controller.i.value = i.toDouble();
                      controller.update();
                    }),
                itemCount: docs.length,
                itemBuilder: (context, index, realIndex) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            height: MediaQuery.of(context).size.height * 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: controller.isDark.value
                                                ? Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Colors.black87,
                                            width: 1,
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                opaque: true,
                                                barrierDismissible: false,
                                                pageBuilder:
                                                    (BuildContext context, _,
                                                        __) {
                                                  return Scaffold(
                                                    backgroundColor:
                                                        controller.isDark.value
                                                            ? Colors.grey[900]
                                                            : Colors.white,
                                                    body: SafeArea(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: IconButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              icon: const Icon(Icons
                                                                  .cancel_sharp),
                                                              color: controller
                                                                      .isDark
                                                                      .value
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black87,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                InteractiveViewer(
                                                              scaleEnabled:
                                                                  true,
                                                              panEnabled: true,
                                                              child: Hero(
                                                                tag: docs[index]
                                                                    .id,
                                                                child: Center(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    //height: 40,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                    imageUrl: data[
                                                                            'imageUrl'] ??
                                                                        Constants
                                                                            .announceLogo,
                                                                    // placeholder: (context, url) =>
                                                                    //     const CupertinoActivityIndicator(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: docs[index].id,
                                            child: CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              fit: BoxFit.cover,
                                              imageUrl: data['imageUrl'] ??
                                                  Constants.announceLogo,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    spacerWidth(15),
                                    // RotatedBox(
                                    //   quarterTurns: 2,
                                    //   child: Container(
                                    //     height:
                                    //         MediaQuery.of(context).size.height * 0.12,
                                    //     width: 1,
                                    //     decoration: BoxDecoration(
                                    //       color: controller.isDark.value
                                    //           ? Colors.white
                                    //           : Color.fromARGB(255, 255, 0, 0)
                                    //               .withOpacity(0.7),
                                    //     ),
                                    //   ),
                                    // ),
                                    spacerWidth(5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //spacerHeight(3),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.title,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Title: ${data['title']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Date : ${data['date']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Time : ${data['time']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                        spacerHeight(1),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.desktop_windows_outlined,
                                              size: 18,
                                              color: controller.isDark.value
                                                  ? Color.fromARGB(
                                                      255, 255, 149, 0)
                                                  : Color.fromARGB(
                                                      255, 255, 149, 0),
                                            ),
                                            spacerWidth(2),
                                            header_4(
                                                "Organizer : ${data['organizers']}",
                                                controller.isDark.value
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                spacerHeight(10),
                                header_4(
                                    "Description : ${data['description']}",
                                    controller.isDark.value
                                        ? Colors.white
                                        : Colors.black87),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          right: 15,
                          child: Icon(Icons.link,
                              size: 20, color: Colors.deepOrange)),
                    ],
                  );
                },
              );
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  static Widget meetingGridListCard(BuildContext context) {
    final Stream<QuerySnapshot> detailStream =
        FirebaseFirestore.instance.collection('meetings').snapshots();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Visibility(
          visible: controller.isLoading.value,
          replacement: StreamBuilder<QuerySnapshot>(
            stream: detailStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("loading");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final docs = snapshot.data?.docs;

              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0),
                      itemCount: docs!.length,
                  itemBuilder: ((context, index) {
                    Map<String , dynamic> data =  docs[index].data() as Map<String , dynamic>;
                    return Text(data['title']);
                  }));
            },
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }
}

class InputField extends StatelessWidget {
  var appController = Get.put(AppController());
  final String? title;
  final String hint;
  final int? linesCount;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? inputType;
  final int? maxLength;
  final bool? showRequired;
  InputField(
      {Key? key,
      this.title,
      required this.hint,
      this.showRequired,
      this.controller,
      this.widget,
      this.linesCount,
      this.inputType,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(title ?? "",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: appController.isDark.value
                      ? Colors.white
                      : Colors.black87,
                )),
            Components.spacerWidth(5),
            Container(
              child: showRequired == true
                  ? const Icon(
                      Icons.star,
                      size: 12,
                      color: Colors.red,
                    )
                  : Container(),
            ),
          ]),
          Container(
            //height: 50,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      appController.isDark.value ? Colors.white : Colors.grey,
                  width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: appController.isDark.value
                          ? Colors.white
                          : Colors.grey),
                  maxLength: maxLength,
                  keyboardType: inputType,
                  maxLines: linesCount,
                  autofocus: false,
                  focusNode: FocusNode(),
                  cursorColor:
                      appController.isDark.value ? Colors.white : Colors.grey,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: appController.isDark.value
                            ? Colors.white
                            : Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: appController.isDark.value
                            ? Colors.white
                            : Colors.grey,
                        width: 0,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                  ),
                )),
                widget == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 8), child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
