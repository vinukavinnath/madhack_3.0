import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Qualifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Qualifications',
            style: kHeading1TextStyle,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/noise.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/noise.webp',
                ),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator
                  }
                  if (!userSnapshot.hasData || userSnapshot.data == null) {
                    return Text('User not logged in'); // Handle case where user is not logged in
                  }
                  final User user = userSnapshot.data!;
                  final String userEmail = user.email ?? ''; // Get current user's email

                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('User').doc(userEmail).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(); // Show loading indicator
                      }
                      var userData = snapshot.data?.data() as Map<String, dynamic>?; // Cast data to Map<String, dynamic>
                      var qualification = userData?['user_qualification'] ?? '';
                      var qualificationDate = userData?['user_qua_date'] ?? '';
                      var qualificationDescription = userData?['user_qua_desc'] ?? '';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Qualification: $qualification',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Qualification Date: $qualificationDate',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Qualification Description: $qualificationDescription',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
