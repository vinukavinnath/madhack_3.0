import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'About Me',
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
                  if (userSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator
                  }
                  if (!userSnapshot.hasData || userSnapshot.data == null) {
                    return Text(
                        'User not logged in'); // Handle case where user is not logged in
                  }
                  final User user = userSnapshot.data!;
                  final String userEmail =
                      user.email ?? ''; // Get current user's email

                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('User')
                        .doc(userEmail)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(); // Show loading indicator
                      }
                      var userData = snapshot.data?.data() as Map<String,
                          dynamic>?; // Cast data to Map<String, dynamic>
                      var fullName = userData?['user_fullname'] ?? '';
                      var dob = userData?['user_dob'] ?? '';
                      var email = userData?['user_email'] ?? '';
                      var mobile = userData?['user_mobile'] ?? '';
                      var links = (userData?['user_links'] as List<dynamic>?)
                              ?.cast<String>() ??
                          [];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name: $fullName',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Date of Birth: $dob',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Email: $email',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Mobile: $mobile',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Links:',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Display each link in the 'user_links' array
                          for (var link in links)
                            Text(
                              link,
                              style: TextStyle(fontSize: 16),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              // Add more information about yourself as needed
            ],
          ),
        ),
      ),
    );
  }
}
