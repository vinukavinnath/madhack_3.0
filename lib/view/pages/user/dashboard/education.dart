import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Education extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Education',
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
                      var university = userData?['user_university'] ?? '';
                      var degree = userData?['user_degree'] ?? '';
                      var fieldOfStudy = userData?['user_fieldofstudy'] ?? '';
                      var startDate = userData?['user_edu_startdate'] ?? '';
                      var endDate = userData?['user_edu_enddate'] ?? '';
                      var description = userData?['user_edu_desc'] ?? '';
                      var isCurrentPosition = userData?['user_edu_iscurrentpos'] ?? false;
      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'University: $university',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Degree: $degree',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Field of Study: $fieldOfStudy',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Start Date: $startDate',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'End Date: $endDate',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Description: $description',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Is Current Position: ${isCurrentPosition ? 'Yes' : 'No'}',
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
