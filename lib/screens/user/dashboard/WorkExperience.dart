import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkExperience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Experience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Experience',
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
                    var company = userData?['user_company'] ?? '';
                    var jobTitle = userData?['user_jobtitle'] ?? '';
                    var isCurrentPosition = userData?['user_work_iscurrentpos'] ?? false;
                    var workStartDate = userData?['user_work_startdate'] ?? '';
                    var workEndDate = userData?['user_work_enddate'] ?? '';
                    var workDesc = userData?['user_work_desc'] ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company: $company',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Job Title: $jobTitle',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Current Position: ${isCurrentPosition ? 'Yes' : 'No'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Start Date: $workStartDate',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'End Date: $workEndDate',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Description: $workDesc',
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
    );
  }
}
