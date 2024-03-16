import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Skills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Skills',
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
          height: screenHeight,
          width: screenWidth,
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
                      var skills = (userData?['user_skills'] as List<dynamic>?)?.cast<String>() ?? []; // Get user skills
      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      
                          SizedBox(height: 10),
                          Text(
                            'Skills:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          // Display each skill
                          for (var skill in skills)
                            Text(
                              skill,
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
