import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../core/constants/app_assets.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.offNamed('/home'); // Cambiar a tu ruta principal o pantalla de inicio
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco para resaltar la imagen
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                AppAssets.logo, // Tu logo en el centro
                width: 250,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30), // Un poco de espacio inferior
            child: Text(
              'PUNTOG',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 167, 91, 248), // Morado personalizado
              ),
            ),
          ),
        ],
      ),
    );
  }
}
