import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Authentication/SignUp/Sign_up.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GetMaterialApp(
    home: Register(),
    debugShowCheckedModeBanner: false
  ));

}