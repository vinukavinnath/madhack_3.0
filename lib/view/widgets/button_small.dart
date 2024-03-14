import 'package:flutter/material.dart';

class CustomButtonSmall extends StatelessWidget {
  const CustomButtonSmall({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: const ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
