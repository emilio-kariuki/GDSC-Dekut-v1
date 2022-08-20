// ignore_for_file: avoid_print, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Authentication/user_logic.dart';
import 'package:gdsc_app/UI/Events/UI/Events.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:gdsc_app/main.dart';
import 'package:get/get.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../Controller/app_controller.dart';
import '../../../Firebase_Logic/UserFirebase.dart';
import '../../../Models/user_model.dart';
import '../../Home/Home.dart';
import '../user_logic.dart';
import '../Login/login_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool _isSigningIn = false;
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.isDark.value ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                //vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Components.showImage(Constants.logo, context),
                ),
                Components.header_1(Constants.register),
                InputField(
                    title: Constants.name,
                    hint: "Enter your user name",
                    controller: username),
                InputField(
                    title: Constants.email,
                    hint: "Enter your email",
                    controller: email),
                InputField(
                    title: Constants.password,
                    hint: "Enter your password",
                    controller: password),
                InputField(
                    title: Constants.confirmPassword,
                    hint: "Confirm your password",
                    controller: confirmPassword),
                Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
                Components.button(Constants.signUp, () async {
                  if (username.text.isEmpty &&
                      email.text.isEmpty &&
                      password.text.isEmpty &&
                      confirmPassword.text.isEmpty) {
                    Components.showMessage(Constants.empty);
                  } else {
                    if (password.text == confirmPassword.text) {
                      final user = await Authentication.registerWithEmail(
                          username.text, email.text, password.text);
                      Get.offAll(() => const Home());
                      if (user != null) {
                        userID = user.uid;
                        the_User = user;
                      }
                    } else {
                      Components.showMessage(Constants.passwordMatch);
                    }
                  }
                }, context),
                Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
                Components.accountText(Constants.haveAccount, Constants.login,
                    () => Get.offAll(() => const Login())),
                Components.showDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Components.signInWith(Constants.google, () async {
                      setState(() {
                        _isSigningIn = true;
                      });

                      User? user = await Authentication.signInWithGoogle(
                              context: context)
                          .then((value) {
                        userID = value!.uid;
                        return value;
                      });
                      if (user != null) {
                        print("USER IS NOT NULL");
                        userID = user.uid;
                        the_User = user;
                        userName = user.displayName!;
                        userEmail = user.email!;
                        createUser(
                            UserClass(user.displayName!, user.email!, '',user.uid,''),
                            user.uid);
                        Get.offAll(() => const Home(),duration:const Duration(milliseconds: 100));
                      }

                      setState(() {
                        _isSigningIn = false;
                      });
                    }),
                    Components.spacerWidth(Dimensions.PADDING_SIZE_SMALL),
                    Components.signInWith(Constants.twitter, () async{
                      final twitterLogin = TwitterLogin(
                        apiKey: '4Fn8237nn65kNWmiVgmMMCsWc',
                        apiSecretKey:
                            'dY3gIp1gqd5QgBDkp888FxyZvF2DwTZRdbnnq0k6r4PoGHBad7',
                        redirectURI:
                            'https://apt-rite-346310.firebaseapp.com/__/auth/handler',
                      );
                      final authResult = await twitterLogin.login();
                      switch (authResult.status) {
                        case TwitterLoginStatus.loggedIn:
                          // success
                          break;
                        case TwitterLoginStatus.cancelledByUser:
                          // cancel
                          break;
                        case TwitterLoginStatus.error:
                          // error
                          break;
                          default:
                           TwitterLoginStatus.error;
                      }
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
