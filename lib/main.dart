import 'package:f_web_service_random_user_template/presentation/pages/startpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Conference Management App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        //fontFamily: 'LeagueSpartan',
      ),
      home: const Startpage(),
    );
  }
}
