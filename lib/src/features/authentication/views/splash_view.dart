import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '/routes/app_routes.dart'; // Import AppRoutes

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _ScrSplashState();
}

class _ScrSplashState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      // Use GetX navigation
      Get.offNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
        ),
        child: Center(
          child: Image.asset(
            "assets/images/itc.png",
            height: 140,
            width: 140,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}