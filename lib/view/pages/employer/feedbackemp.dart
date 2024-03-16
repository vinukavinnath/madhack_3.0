import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'jobposting.dart';

class FeedBackEmp extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final String docid;
  final String email;

  const FeedBackEmp({
    required this.jobData,
    required this.docid,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();
    TextEditingController cvController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    // Fetch existing data from Firestore
    FirebaseFirestore.instance
        .collection('Jobs')
        .doc(docid)
        .collection('applyinfo')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Document exists, retrieve data
        final data = documentSnapshot.data() as Map<String, dynamic>?;
        final existingCV = data?['cv'] ?? ''; // Get existing cv, if available
        final existingMessage = data?['message'] ??
            ''; // Get existing message, if available
        cvController.text = existingCV; // Set initial text of the cv TextField
        messageController.text =
            existingMessage; // Set initial text of the message TextField
      } else {
        // Document does not exist
        print('Document does not exist');
      }
    }).catchError((error) {
      // Handle errors here
      print('Failed to fetch data: $error');
    });

    void saveFeedback(String feedback) {
      // Save the feedback to Firestore
      FirebaseFirestore.instance
          .collection('Jobs')
          .doc(docid)
          .collection('applyinfo')
          .doc(email)
          .update({'feedback': feedback})
          .then((value) {
        // Feedback saved successfully
        print('Feedback saved successfully');
        // Navigate to the job posting page
        Navigator.of(context).pop(); // Close the current page
        // Assuming JobPostingPage is the page you want to navigate to
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => JobPosting()));
      }).catchError((error) {
        // Handle errors here
        print('Failed to save feedback: $error');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cvController,
              decoration: InputDecoration(
                hintText: 'CV',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please provide your feedback:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: feedbackController,
                decoration: InputDecoration(
                  hintText: 'Enter your feedback here',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // Allowing multiple lines of feedback
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String feedback = feedbackController.text;
                if (feedback
                    .trim()
                    .isNotEmpty) {
                  saveFeedback(feedback);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter your feedback'),
                  ));
                }
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}