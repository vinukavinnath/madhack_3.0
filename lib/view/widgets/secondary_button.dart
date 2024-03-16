import 'package:flutter/material.dart';
import 'package:async_and_await/constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.title,
    required this.process,
    super.key,
  });

  final String? title;
  final void Function()? process;

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width;
    return Container(
      width: buttonWidth,
      margin: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: process,
        style: ElevatedButton.styleFrom(
          elevation: 6.0,
          backgroundColor: kLightBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: kOceanBlueColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(title!, style: kSecondaryButtonTextStyle),
        ),
      ),
    );
  }
}
