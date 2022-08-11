// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gdsc_app/Models/user_model.dart';

final firestoreInstance = FirebaseFirestore.instance;

void createUser(UserClass user, String id) async {
  firestoreInstance.collection('users').doc(id).set({
    "username": user.name,
    "email": user.email,
    "password": user.password,
  });
}

Future<UserClass> getUser(String userID) async {
  var data;
  firestoreInstance.collection("users").doc(userID).get().then((value) {
    data = value.data();
  });
  return UserClass.fromJson(data);
}


