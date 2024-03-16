import 'package:flutter/material.dart';

import 'feedbackemp.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final String docid;

  final String fullName;
  final String profileImage;
  final String mobile;
  final String dob;
  final String email;
  final List<String> links;
  final String company;
  final String jobTitle;
  final bool isCurrentPosition;
  final String workStartDate;
  final String workEndDate;
  final String workDescription;
  final String university;
  final String degree;
  final String fieldOfStudy;
  final String eduStartDate;
  final String eduEndDate;
  final String eduDescription;
  final bool isEduCurrentPosition;
  final List<String> skills;
  final String qualification;
  final String qualificationDate;
  final String qualificationDescription;

  const UserDetails({
    required this.jobData,
    required this.docid,
    Key? key,
    required this.fullName,
    required this.profileImage,
    required this.mobile,
    required this.dob,
    required this.email,
    required this.links,
    required this.company,
    required this.jobTitle,
    required this.isCurrentPosition,
    required this.workStartDate,
    required this.workEndDate,
    required this.workDescription,
    required this.university,
    required this.degree,
    required this.fieldOfStudy,
    required this.eduStartDate,
    required this.eduEndDate,
    required this.eduDescription,
    required this.isEduCurrentPosition,
    required this.skills,
    required this.qualification,
    required this.qualificationDate,
    required this.qualificationDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(fullName, style: TextStyle(fontWeight: FontWeight.bold)),
              background: Image.network(
                profileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('Full Name: $fullName'),
                      SizedBox(height: 10,),
                      Text('Mobile: $mobile'),
                      SizedBox(height: 10,),
                      Text('Date of Birth: $dob'),
                      SizedBox(height: 10,),
                      Text('Email: $email'),
                      SizedBox(height: 10,),
                      Text('Links: ${links.join(", ")}'),
                      SizedBox(height: 10,),
                      Text('Company: $company'),
                      SizedBox(height: 10,),
                      Text('Job Title: $jobTitle'),
                      SizedBox(height: 10,),
                      Text('Is Current Position: $isCurrentPosition'),
                      SizedBox(height: 10,),
                      Text('Work Start Date: $workStartDate'),
                      SizedBox(height: 10,),
                      Text('Work End Date: $workEndDate'),
                      SizedBox(height: 10,),
                      Text('Work Description: $workDescription'),
                      SizedBox(height: 10,),
                      Text('University: $university'),
                      SizedBox(height: 10,),
                      Text('Degree: $degree'),
                      SizedBox(height: 10,),
                      Text('Field of Study: $fieldOfStudy'),
                      SizedBox(height: 10,),
                      Text('Education Start Date: $eduStartDate'),
                      SizedBox(height: 10,),
                      Text('Education End Date: $eduEndDate'),
                      SizedBox(height: 10,),
                      Text('Education Description: $eduDescription'),
                      SizedBox(height: 10,),
                      Text('Is Current Education Position: $isEduCurrentPosition'),
                      SizedBox(height: 10,),
                      Text('Skills: ${skills.join(", ")}'),
                      SizedBox(height: 10,),
                      Text('Qualification: $qualification'),
                      SizedBox(height: 10,),
                      Text('Qualification Date: $qualificationDate'),
                      SizedBox(height: 10,),
                      Text('Qualification Description: $qualificationDescription'),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FeedBackEmp(
                                jobData: jobData,
                                docid: docid,
                                email: email,
                              )),
                            );
                          },
                          child: Text('Add Feedback'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
