import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplyNow extends StatefulWidget {
  final Map<String, dynamic> jobData;
  final String docid;

  const ApplyNow({
    Key? key,
    required this.jobData,
    required this.docid,
  }) : super(key: key);

  @override
  _ApplyNowState createState() => _ApplyNowState();
}

class _ApplyNowState extends State<ApplyNow> {
  TextEditingController cvController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobData['emp_comp_name'] ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.jobData['emp_profile_img'] != null)
                Image.network(
                  widget.jobData['emp_profile_img'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16.0),
              Text('Category: ${widget.jobData['emp_category'] ?? ''}'),
              SizedBox(height: 8.0),
              Text('Location: ${widget.jobData['emp_location'] ?? ''}'),
              SizedBox(height: 8.0),
              Text('Workspace: ${widget.jobData['emp_workspace'] ?? ''}'),
              SizedBox(height: 8.0),
              Text('Job Type: ${widget.jobData['emp_jobtype'] ?? ''}'),
              SizedBox(height: 8.0),
              Text('Salary: \$${widget.jobData['emp_min_Salary'] ?? ''}-${widget.jobData['emp_max_Salary'] ?? ''} / Mo'),

              SizedBox(height: 40.0),
              TextField(
                controller: cvController,
                decoration: InputDecoration(
                  labelText: 'CV',
                  hintText: 'Enter your CV link here',
                  border: OutlineInputBorder(),
                ),
              ),

              Text(
                'Add your CV link here....',
                style: TextStyle(
                  fontSize: 16.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // You can adjust the font weight as needed
                ),
              ),

              SizedBox(height: 16.0),
              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter message here',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
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
                applyToJob(context);
              },
              child: Text('Submit'),
            ),
            IconButton(
              onPressed: () {
                // Function to handle saving the job
                // Implement the functionality for saving the job
              },
              icon: Icon(Icons.save_as_rounded),
            ),
          ],
        ),
      ),
    );
  }

  void applyToJob(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? userEmail = user.email;
      Timestamp now = Timestamp.now();
      String cv = cvController.text;
      String message = messageController.text;

      try {
        await FirebaseFirestore.instance
            .collection('Jobs')
            .doc(widget.docid)
            .collection('applyinfo')
            .doc(userEmail)
            .set({
          'userEmail': userEmail,
          'dateTime': now,
          'cv': cv,
          'message': message,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Applied to the job successfully!'),
        ));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to apply to the job. Please try again later.'),
        ));
        print('Error applying to job: $error');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You need to be logged in to apply to this job.'),
      ));
    }
  }

  @override
  void dispose() {
    cvController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
