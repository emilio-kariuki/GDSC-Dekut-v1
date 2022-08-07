import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class Components{

  Widget header_1(String text){
    return Text(
      text,
      style: GoogleFonts.quicksand(
        color: Colors.black87,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    );
  }
  Widget header_2(String text){
    return Text(
      text,
      style: GoogleFonts.quicksand(
        color: Colors.black87,
        fontSize:24,
        fontWeight: FontWeight.w400,
      ),
    );
  }
  Widget header_3(String text){
    return Text(
      text,
      style: GoogleFonts.quicksand(
        color: Colors.black87,
        fontSize:18,
        fontWeight: FontWeight.w400,
      ),
    );
  }
  Widget showImage(String imageName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(2),
          height: Get.context!.width * 0.06,
          width: Get.context!.width * 0.14,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                "assets/$imageName.png",
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
                        padding: const EdgeInsets.only(right: 8),
                        child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}