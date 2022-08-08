// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  static Future<User?> registerWithEmail(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
        
  }
}
