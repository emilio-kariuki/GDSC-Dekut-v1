import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontWeight: FontWeight.w500,
      ),
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

  static Widget button(String text, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: SizedBox(
        height: Get.context!.height * 0.075,
        width: Get.context!.width * 0.75,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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

 static showMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 0, 188, 25),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
 

  static Widget showImage(String imageName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(2),
          height: Get.context!.width * 0.09,
          width: Get.context!.width * 0.16,
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
