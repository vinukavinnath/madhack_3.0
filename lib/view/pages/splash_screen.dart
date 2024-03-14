import 'dart:async';

import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //Timing Property
    Timer(const Duration(seconds: 3), () {
      context.go('/root');
    });

    return const SafeArea(
      child:  Scaffold(
        backgroundColor: kWhiteColor,
        body: Center(
          child: Image(
            image: AssetImage("assets/logos/madhack.webp"),
          ),
        ),
      ),
    );
  }
}
