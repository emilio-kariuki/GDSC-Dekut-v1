// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gdsc_app/Firebase_Logic/EventFirebase.dart';
import 'package:gdsc_app/UI/Authentication/user_logic.dart';
import 'package:get/get.dart';

import '../UI/Events/Model/Event_model.dart';

class AppController extends GetxController {
  var isDark = false.obs;
  var events = <EventModel>[].obs;
  var isLoading = true.obs;
  var selectedDate = 'Date'.obs;
  var selectTime = '5:00'.obs;

  void changeTheme(bool value) {
    if (value == true) {
      Get.changeTheme(ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[900],
        primaryColor: Colors.grey[900],
        accentColor: Colors.grey[900],
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        canvasColor: Colors.grey[900],
        cardColor: Colors.grey[900],
        dividerColor: Colors.grey[100],
        disabledColor: Colors.grey[200],
        errorColor: Colors.red,
        focusColor: Colors.grey[200],
        hoverColor: Colors.grey[400],
        highlightColor: Colors.grey[200],
        indicatorColor: Colors.grey[100],
        unselectedWidgetColor: Colors.grey[900],
        secondaryHeaderColor: Colors.grey[900],
      ));
    } else {
      Get.changeTheme(ThemeData.light().copyWith(
        backgroundColor: Colors.grey[100],
        primaryColor: Colors.grey[100],
        accentColor: Colors.grey[100],
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        canvasColor: Colors.grey[100],
        cardColor: Colors.grey[100],
        dividerColor: Colors.grey[900],
        disabledColor: Colors.grey[900],
        errorColor: Colors.red,
        focusColor: Colors.grey[800],
        hoverColor: Colors.grey[800],
        highlightColor: Colors.grey[800],
        indicatorColor: Colors.grey[800],
        unselectedWidgetColor: Colors.grey[100],
        secondaryHeaderColor: Colors.grey[100],
      ));
    }
  }

  void fetchEvents() async {
    try {
      isLoading(true);
      //var event = await ActionFirebase.getEvents();
      //events.value = event;
      //print("The events are : $event");
      isLoading(false);
    } catch (e) {
      print(e);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
