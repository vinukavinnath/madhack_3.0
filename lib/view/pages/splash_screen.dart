import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Timing Property
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacementNamed('/home');
    // });

    return const Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: Image(
          image: AssetImage("assets/logos/madhack.webp"),
        ),
      ),
    );
  }
}
