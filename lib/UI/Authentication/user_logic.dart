// ignore_for_file: unused_local_variable, avoid_print, avoid_types_as_parameter_names, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Firebase_Logic/UserFirebase.dart';
import 'package:gdsc_app/Models/user_model.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../Events/Model/Event_model.dart';

class Authentication {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static FirebaseAuth auth = FirebaseAuth.instance;
  static final controller = Get.put(AppController());
  static Future<User?> registerWithEmail(
      String name, String email, String password) async {
    User? user;
    user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      createUser(
          UserClass(name, email, 'empty', 'empty', 'empty', 'empty', user.uid,
              'empty', Constants.defaultIcon),
          user.uid);
      userName = user.displayName ?? "Unknown";
      email = user.email!;
    }
    controller.isSignedIn.value = true;
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

    controller.isSignedIn.value == true;

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
      userName = user.displayName!;
      userEmail = user.email!;
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);  
        controller.isSignedIn.value = true;
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        print("The errors");
        print(e.code);
        print(e.message);

        if (e.code == 'account-exists-with-different-credential') {
          print("Account exists with different credential");
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          print("Invalid credential");
          // handle the error here
        }
      } catch (e) {
        print("The error for google sign in is : $e");
        // handle the error here
      }
    }
    return user;
  }

  static Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await googleSignIn.signOut();
    await auth.signOut();
  }

  Future<List<UserClass>> getUser(String userID) async {
    var data;
    firestoreInstance.collection("users").doc(userID).get().then((value) {
      data = value.data();
    });
    return userFromJson(data);
  }

  void updateUser(UserClass user, String id) {
    firestoreInstance.collection("users").doc(id).update(user.toJson());
  }
}
