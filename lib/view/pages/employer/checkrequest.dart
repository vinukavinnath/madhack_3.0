import 'package:async_and_await/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userdetails.dart';

class CheckRequest extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final String docid;

  const CheckRequest({
    Key? key,
    required this.jobData,
    required this.docid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Skills',
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
        body: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
          child: Container(
            height: screenHeight,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/noise.webp',
                  ),
                  fit: BoxFit.fill),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Jobs')
                  .doc(docid)
                  .collection('applyinfo')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No requests found.'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot request = snapshot.data!.docs[index];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('User')
                          .doc(request['userEmail']) // Assuming userEmail is stored in each request document
                          .get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (userSnapshot.hasError) {
                          return Center(
                            child: Text('Error: ${userSnapshot.error}'),
                          );
                        }
                        if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                          return Center(
                            child: Text('User not found.'),
                          );
                        }
                        String userFullname = userSnapshot.data!['user_fullname'];
                        String userProfileImage = userSnapshot.data!['user_profileimage']; // Assuming user_profileimage field contains image URL
                        String userMobile = userSnapshot.data!['user_mobile']; // Assuming user_mobile field contains mobile number
                        String userEmail = userSnapshot.data!['user_email']; // Assuming user_email field contains email address

                        // Retrieve all additional user details
                        String userDob = userSnapshot.data!['user_dob'];
                        String userCompany = userSnapshot.data!['user_company'];
                        String userJobTitle = userSnapshot.data!['user_jobtitle'];
                        bool userIsCurrentPosition = userSnapshot.data!['user_work_iscurrentpos'];
                        String userWorkStartDate = userSnapshot.data!['user_work_startdate'];
                        String userWorkEndDate = userSnapshot.data!['user_work_enddate'];
                        String userWorkDescription = userSnapshot.data!['user_work_desc'];
                        String userUniversity = userSnapshot.data!['user_university'];
                        String userDegree = userSnapshot.data!['user_degree'];
                        String userFieldOfStudy = userSnapshot.data!['user_fieldofstudy'];
                        String userEduStartDate = userSnapshot.data!['user_edu_startdate'];
                        String userEduEndDate = userSnapshot.data!['user_edu_enddate'];
                        String userEduDescription = userSnapshot.data!['user_edu_desc'];
                        bool userIsEduCurrentPosition = userSnapshot.data!['user_edu_iscurrentpos'];
                        List<dynamic> userSkills = userSnapshot.data!['user_skills'];
                        List<dynamic> links = userSnapshot.data!['user_links'];
                        String userQualification = userSnapshot.data!['user_qualification'];
                        String userQualificationDate = userSnapshot.data!['user_qua_date'];
                        String userQualificationDescription = userSnapshot.data!['user_qua_desc'];

                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetails(
                                    jobData: jobData,
                                    docid: docid,
                                    fullName: userFullname,
                                    profileImage: userProfileImage,
                                    mobile: userMobile,
                                    dob: userDob,
                                    email: userEmail,
                                    links: List<String>.from(links.map((e) => e.toString())),
                                    company: userCompany,
                                    jobTitle: userJobTitle,
                                    isCurrentPosition: userIsCurrentPosition,
                                    workStartDate: userWorkStartDate,
                                    workEndDate: userWorkEndDate,
                                    workDescription: userWorkDescription,
                                    university: userUniversity,
                                    degree: userDegree,
                                    fieldOfStudy: userFieldOfStudy,
                                    eduStartDate: userEduStartDate,
                                    eduEndDate: userEduEndDate,
                                    eduDescription: userEduDescription,
                                    isEduCurrentPosition: userIsEduCurrentPosition,
                                    skills: List<String>.from(userSkills.map((e) => e.toString())),
                                    qualification: userQualification,
                                    qualificationDate: userQualificationDate,
                                    qualificationDescription: userQualificationDescription,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(userProfileImage),
                            ),
                            title: Text(userFullname),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userMobile), // Display user mobile number
                                Text(userEmail), // Display user email address
                              ],
                            ),
                            // Add more fields as needed
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
