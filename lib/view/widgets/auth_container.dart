import 'package:flutter/material.dart';
import 'package:async_and_await/constants.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({
    super.key,
    required this.imagePath,
    required this.function,
  });

  final String imagePath;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: kOceanBlueColor,width: 2.0)
        ),
        child: Image(
          image: AssetImage(
            imagePath,
          ),
        ),
      ),
    );
  }
}