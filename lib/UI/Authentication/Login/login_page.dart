// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Models/user_model.dart';
import 'package:get/get.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../Firebase_Logic/UserFirebase.dart';
import '../../../Util/App_Constants.dart';
import '../../../Util/App_components.dart';
import '../../../Util/dimensions.dart';
import '../../../main.dart';
import '../../Events/UI/Events.dart';
import '../../Home/Home.dart';
import '../SignUp/Sign_up.dart';
import '../user_logic.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isSigningIn = false;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
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
                Components.spacerHeight(Dimensions.PADDING_SIZE_OVER_LARGE),
                Components.header_1(Constants.login),

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
                Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
                Components.button(Constants.login, () async {
                  if (username.text.isEmpty &&
                      email.text.isEmpty &&
                      password.text.isEmpty) {
                    Components.showMessage(Constants.empty);
                  } else {
                    final user =
                        await Authentication.signInWithEmailAndPassword(
                            username.text, email.text, password.text);
                    controller.isSignedIn.value
                        ? const CircularProgressIndicator()
                        : Components.showMessage("Logged in successfully");
                    controller.isSignedIn.value = false;
                    Get.offAll(() => const Home());
                    if (user != null) {
                      userID = user.uid;
                      the_User = user;
                    }
                  }
                }, context),
                //Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
                Components.accountText(Constants.noAccount, Constants.register,
                    () => Get.offAll(() => const Register())),
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
                            UserClass(
                                user.displayName!,
                                user.email!,
                                'empty',
                                'empty',
                                'empty',
                                'empty',
                                user.uid,
                                'empty',
                                Constants.defaultIcon),
                            user.uid);
                            
                        Get.offAll(() => const Home());
                      }

                      setState(() {
                        _isSigningIn = false;
                      });
                    }),
                    Components.spacerWidth(Dimensions.PADDING_SIZE_SMALL),
                    Components.signInWith(Constants.twitter, () async {
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
