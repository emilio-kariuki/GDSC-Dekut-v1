import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false
  ));

}