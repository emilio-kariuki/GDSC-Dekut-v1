// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gdsc_app/Util/dimensions.dart';

import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class Components {
  static Widget header_1(String text) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
        color: Colors.black87,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget header_2(String text) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
        color: Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static Widget header_3(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  static   Widget showDividerLine() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: Dimensions.PADDING_SIZE_SMALL,
    );
  }


  static Widget spacerWidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget spacerHeight(double height) {
    return SizedBox(
      height: height,
    );
  }
  static   Widget avatar() {
    return const CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('assets/profile.jpg'),
    );
  }
  static   Widget personalInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          avatar(),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [header_3(userName,Colors.black87), header_3(userEmail,Colors.black38)],
          ),
        ],
      ),
    );
  }


  static Widget accountText(String text_1, String text_2, Function() function) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          header_3(text_1, Colors.black),
          InkWell(onTap: function, child: header_3(text_2, Colors.green))
        ],
      ),
    );
  }
  static   Widget cardButton(IconData iconName, String action, Function() function) {
    return InkWell(
      onTap: function,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  iconName,
                  size: 18,
                  color: Colors.black54,
                ),
                const SizedBox(width: 15),
                header_3(action,Colors.black87),
              ],
            ),
            Expanded(child: Container()),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }


  static Widget button(
      String text, Function() onPressed, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          vertical: Dimensions.PADDING_SIZE_OVER_LARGE),
      child: SizedBox(
        height: size.height * 0.075,
        width: size.width * 0.75,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.CONTAINER_SIZE_SMALL),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.deepPurple,
            ),
          ),
          child: Text(text,
              style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  static showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 0, 188, 25),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget showDivider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_SMALL),
            child: const Divider(
              thickness: 0.5,
              height: Dimensions.CONTAINER_SIZE_OVER_LARGE,
              color: Colors.black26,
            ),
          )),
          Text("OR",
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.black26)),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_SMALL),
            child: const Divider(
              thickness: 0.5,
              height: Dimensions.CONTAINER_SIZE_LARGE,
              color: Colors.black26,
            ),
          )),
        ],
      ),
    );
  }

  static Widget signInWith(String imageUrl, Function() function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: Dimensions.CONTAINER_SIZE_LARGE,
        width: Dimensions.CONTAINER_SIZE_LARGE,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        child: SvgPicture.asset(
          imageUrl,
          width: Dimensions.CONTAINER_SIZE_LARGE,
          height: Dimensions.CONTAINER_SIZE_LARGE,
          color: Colors.black,
        ),
      ),
    );
  }

  static Widget showImage(String imageName, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_OVER_LARGE),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(2),
          height: size.height * 0.09,
          width: size.width * 0.16,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                imageName,
              ).image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final int? linesCount;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? inputType;
  final int? maxLength;
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.linesCount,
      this.inputType,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          Container(
            //height: 50,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  maxLength: maxLength,
                  keyboardType: inputType,
                  maxLines: linesCount,
                  autofocus: false,
                  focusNode: FocusNode(),
                  cursorColor: Colors.grey,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                  ),
                )),
                widget == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 8), child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
