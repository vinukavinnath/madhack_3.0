import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/noise.webp',
                ),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add padding here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display employee profile image
                  (jobData['emp_profile_img'] != null)
                      ? Image.network(
                          jobData['emp_profile_img'],
                          width: 100, // Adjust width as needed
                          height: 100, // Adjust height as needed
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100, // Adjust width as needed
                          height: 100, // Adjust height as needed
                          color: Colors.grey, // Placeholder color
                          child: Center(
                            child: Text(
                              'Image not available',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  SizedBox(height: 16.0),
                  // Add space between image and other details
                  // Display job details here
                  Text('Category: ${jobData['emp_category'] ?? ''}'),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('Location: ${jobData['emp_location'] ?? ''}'),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('Workspace: ${jobData['emp_workspace'] ?? ''}'),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('Job Type: ${jobData['emp_jobtype'] ?? ''}'),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                      'Salary: \$${jobData['emp_min_Salary'] ?? ''}-${jobData['emp_max_Salary'] ?? ''} / Mo'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: PrimaryButton(
                      process: () {
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
                      title: 'Check the Requests',
                    ),
                  ),
                  // Add more details as needed
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
