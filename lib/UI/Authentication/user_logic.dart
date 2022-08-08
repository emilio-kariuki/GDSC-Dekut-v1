// ignore_for_file: unused_local_variable, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Firebase_Logic/UserFirebase.dart';
import 'package:gdsc_app/Models/user_model.dart';

import '../../main.dart';

class Authentication {
  static Future<User?> registerWithEmail(
      String name, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      createUser(UserClass(name, email, password), user.uid);
    }
    return user;
  }

  static Future<User?> signInWithEmailAndPassword(
      String name, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    user = (await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      createUser(UserClass(name, email, password), user.uid);
    }
    return user;
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    // FirebaseAuth.instance.currentUser?.delete();
    // User? user;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("USER EXISTS");
      print(user.uid);
      userID = user.uid;
    }

    return firebaseApp;
  }
  
}
