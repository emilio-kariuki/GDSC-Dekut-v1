// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdsc_app/Firebase_Logic/EventFirebase.dart';
import 'package:gdsc_app/UI/Authentication/user_logic.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../UI/Events/Model/Event_model.dart';

class AppController extends GetxController {
  var isDark = false.obs;
  var events = <EventModel>[].obs;
  var currentPage = 0.obs;
  var isSent = false.obs;
  var isLoading = true.obs;
  var selectedDate = 'Date'.obs;
  var selectTime = '5:00'.obs;
  Rx<File> image = File(Constants.logo).obs;
  final picker = ImagePicker();
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  var i = 0.obs;
  var docsLength = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getThemeStatus();
  }

  void fetchEvents() async {
    try {
      isLoading(true);
      isLoading(false);
    } catch (e) {
      print(e);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, maxHeight: 480, maxWidth: 640, imageQuality: 100);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      print("THe image value is : ${image.value}");
      update();
    } else {
      print('No image selected.');
    }
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isDark.value);
  }

  getThemeStatus() async {
    var isDarkTheme = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isDark.value = (await isDarkTheme.value);
  }
}
