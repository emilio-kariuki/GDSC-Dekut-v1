// ignore_for_file: unused_local_variable, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Firebase_Logic/UserFirebase.dart';
import 'package:gdsc_app/Models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }
}
