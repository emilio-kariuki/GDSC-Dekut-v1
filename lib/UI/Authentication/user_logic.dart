// ignore_for_file: unused_local_variable, avoid_print, avoid_types_as_parameter_names, non_constant_identifier_names, prefer_typing_uninitialized_variables
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
      userName = user.displayName!;
      email = user.email!;
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
      userName = user.displayName!;
      userEmail = user.email!;
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
      userName = user.displayName!;
      userEmail = user.email!;
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

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
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }

  static Future<void> signOut(){
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.signOut();
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
