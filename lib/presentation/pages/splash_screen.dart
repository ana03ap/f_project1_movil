import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 2), () async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name');

    if (savedName != null && savedName.isNotEmpty) {
      Get.offNamed('/startpage');
    } else {
      Get.offNamed('/home');
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/splashscreen.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
