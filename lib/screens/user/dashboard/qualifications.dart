import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Qualifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qualifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qualifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
    );
  }
}
