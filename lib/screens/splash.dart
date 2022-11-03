import 'dart:async';

import 'package:crypto_tracker/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyRegister()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
              Colors.grey[900],
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/crypto.json'),
        ],
      )),
    );
  }
}