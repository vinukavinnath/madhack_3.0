import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: screenHeight,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/noise.webp',
            ),
            fit: BoxFit.fill),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'We are a passionate group of undergraduate students from Kotelawala Defense University, driven by a shared vision to innovate and create impactful solutions. Our diverse backgrounds and areas of expertise converge to form a dynamic team dedicated to crafting intuitive and cutting-edge mobile applications.',
            textAlign: TextAlign.center,
            style: kNormalTextStyle.copyWith(fontSize: 18),
          ),
        ),
      ),
    )));
  }
}
