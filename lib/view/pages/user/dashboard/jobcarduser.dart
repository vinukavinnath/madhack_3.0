import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'jobdetailspageuser.dart';



class JobCardUser extends StatelessWidget {
  final String? searchKeyword;
  final String? desiredLocation; // Add desiredLocation variable
  final String? sortBy;

  JobCardUser({
    this.searchKeyword,
    this.desiredLocation,
    this.sortBy,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error fetching data: ${snapshot.error}');
          } else if (snapshot.data!.docs.isEmpty) {
            return Text('No job data available.');
          } else {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  final jobData = document.data() as Map<String, dynamic>;

                  // Check if the job matches the search keyword
                  if (searchKeyword != null &&
                      jobData['emp_category'] != null &&
                      !jobData['emp_category'].toLowerCase().contains(
                          searchKeyword!.toLowerCase())) {
                    // Skip this job if it doesn't match the search keyword
                    return SizedBox.shrink();
                  }

                  return buildJobCard(context, document, jobData);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildJobCard(BuildContext context, DocumentSnapshot document,
      Map<String, dynamic> jobData) {
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

    return GestureDetector(
      onTap: () async {
        // Check if the current user has already viewed this job
        List<dynamic> viewedBy = jobData['viewed_by'] ?? [];
        if (!viewedBy.contains(currentUserUid)) {
          // If the user has not viewed this job before, update view count
          viewedBy.add(currentUserUid);
          await FirebaseFirestore.instance.collection('Jobs')
              .doc(document.id)
              .update({
            'viewed_by': viewedBy,
            'view_count': FieldValue.increment(1)
          });
        }

        //Navigate to job details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                JobDetailsPageuser(jobData: jobData, docid: document.id),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(jobData['emp_profile_img'] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Row(
            children: [
              Flexible(
                child: Text(
                  jobData['emp_category'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              Visibility(
                visible: jobData['view_count'] != null,
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye, color: Colors.black45, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${jobData['view_count']} ',
                      style: TextStyle(color: Colors.black45, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '${jobData['emp_comp_name']} - ',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      jobData['emp_location'] ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(jobData['emp_workspace'] ?? ''),
                  ),
                  SizedBox(width: 12),
                  Container(
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(jobData['emp_jobtype'] ?? ''),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '\$${jobData['emp_min_Salary'] ??
                              ''}-${jobData['emp_max_Salary'] ?? ''} / Mo',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}