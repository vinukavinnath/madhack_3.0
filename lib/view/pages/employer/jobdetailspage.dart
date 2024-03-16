import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../user/dashboard/applynow.dart';
import 'checkrequest.dart';

class JobDetailsPage extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final String docid; // Add docid field


  const JobDetailsPage({
    Key? key,
    required this.jobData,
    required this.docid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobData['emp_comp_name'] ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display employee profile image
              if (jobData['emp_profile_img'] != null)
                Image.network(
                  jobData['emp_profile_img'],
                  width: 100, // Adjust width as needed
                  height: 100, // Adjust height as needed
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16.0),
              // Add space between image and other details
              // Display job details here
              Text('Category: ${jobData['emp_category'] ?? ''}'),
              SizedBox(height: 8.0,),
              Text('Location: ${jobData['emp_location'] ?? ''}'),
              SizedBox(height: 8.0,),
              Text('Workspace: ${jobData['emp_workspace'] ?? ''}'),
              SizedBox(height: 8.0,),
              Text('Job Type: ${jobData['emp_jobtype'] ?? ''}'),
              SizedBox(height: 8.0,),
              Text('Salary: \$${jobData['emp_min_Salary'] ??
                  ''}-${jobData['emp_max_Salary'] ?? ''} / Mo'),
              // Add more details as needed
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the next page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckRequest(
                        jobData: jobData,
                        docid: docid,
                    ), // Replace ApplyNowPage with your next page
                  ),
                );
              },
              child: Text('Check the Requests'),
            ),
          ],
        ),
      ),

    );
  }
}
