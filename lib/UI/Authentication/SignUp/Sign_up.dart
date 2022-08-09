// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Authentication/user_logic.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:gdsc_app/main.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Components.showImage(Constants.logo),
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
                Components.button(
                  Constants.signUp,
                  () async {
                    if (username.text.isEmpty &&
                        email.text.isEmpty &&
                        password.text.isEmpty &&
                        confirmPassword.text.isEmpty) {
                      Components.showMessage(Constants.empty);
                    } else {
                      if (password.text == confirmPassword.text) {
                        final user = await Authentication.registerWithEmail(
                            username.text, email.text, password.text);
                        Get.offAll(() => const Login());
                        if (user != null) {
                          userID = user.uid;
                          the_User = user;
                        }
                      } else {
                        Components.showMessage(Constants.passwordMatch);
                      }
                    }
                  },
                ),
                Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
                Components.accountText(Constants.haveAccount, Constants.login,
                    () => Get.offAll(() => const Login()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
