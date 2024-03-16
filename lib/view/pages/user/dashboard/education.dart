import 'package:flutter/material.dart';

class Education extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Education',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                  'nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(fontSize: 16),
            ),
            // Add more information about yourself as needed
          ],
        ),
      ),
    );
  }
}
