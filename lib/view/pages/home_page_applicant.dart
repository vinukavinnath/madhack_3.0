import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class HomePageApplicant extends StatelessWidget {
  const HomePageApplicant({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Center(
            child: Text('Home Page Applicant'),
          ),
        ),
      ),
    );
  }
}
