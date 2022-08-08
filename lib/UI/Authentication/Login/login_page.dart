import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Util/App_Constants.dart';
import '../../../Util/App_components.dart';
import '../../../Util/dimensions.dart';
import '../SignUp/Sign_up.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    final confirmPassword = TextEditingController();

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
                Components.spacerHeight( Dimensions.PADDING_SIZE_OVER_LARGE),
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
                Components.button(
                  Constants.login,
                  () {
                    print("Login");
                  },
                ),
                Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
                Components.accountText(Constants.noAccount, Constants.register, () => Get.offAll(()=> const Register()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}