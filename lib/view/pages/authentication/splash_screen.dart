import 'dart:async';

import 'package:async_and_await/constants.dart';
import 'package:async_and_await/controller/root_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //Timing Property
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const RootPage()));
    });

    return const SafeArea(
      child:  Scaffold(
        backgroundColor: kWhiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Image(
                image: AssetImage("assets/logos/madhack.webp"),
              ),
            ),
            Text('JobConnect',style: kHeading1TextStyle,),
          ],
        ),
      ),
    );
  }
}
