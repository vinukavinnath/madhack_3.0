import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const CustomFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
