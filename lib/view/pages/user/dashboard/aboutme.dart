import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
      ),
      body: FutureBuilder(
        future: getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // Extract user data from the snapshot
          var userData = snapshot.data as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                userData.containsKey('user_fullname')
                    ? Text(
                  userData['user_fullname'] ?? '', // Display user fullname
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    : Text(
                  'Please sign in to view your profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                userData.containsKey('about_me')
                    ? Text(
                  userData['about_me'] ?? '', // Display user about me information
                  style: TextStyle(fontSize: 16),
                )
                    : userData.containsKey('user_fullname')
                    ? Text(
                  'No additional information found',
                  style: TextStyle(fontSize: 16),
                )
                    : Container(),
                // Add more information about yourself as needed
              ],
            ),
          );
        },
      ),
    );
  }

  // Function to get current user's data from Firestore
  Future<Map<String, dynamic>> getCurrentUserData() async {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Return an empty map if the user is not authenticated
      return {};
    }

    // Get current user's email
    String email = user.email ?? '';
    if (email.isEmpty) {
      // Return an empty map if the user's email is null or empty
      return {};
    }

    // Query Firestore to get user data based on email
    var querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(email) // Assuming doc ID is the user email
        .get();
    if (!querySnapshot.exists) {
      // Return an empty map if user data not found
      return {};
    }

    // Extract user data from the query snapshot
    var userData = querySnapshot.data() as Map<String, dynamic>;
    return userData;
  }
}
