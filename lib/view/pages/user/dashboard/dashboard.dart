import 'package:async_and_await/view/pages/user/dashboard/updateaboutpage.dart';
import 'package:async_and_await/view/pages/user/dashboard/qualifications.dart';
import 'package:async_and_await/view/pages/user/dashboard/skills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'WorkExperience.dart';
import 'aboutme.dart';
import 'education.dart';

class DashBoard extends StatefulWidget {
  final String? userUid;
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final String selectedCountryCode;
  final List<String> links;
  final TextEditingController jobtitleController;
  final TextEditingController companyController;
  final bool isCurrentPosition;
  final TextEditingController workstartdateController;
  final TextEditingController workenddateController;
  final TextEditingController descriptionController;
  final TextEditingController schoolController;
  final TextEditingController degreeController;
  final TextEditingController fieldofstudyController;
  final TextEditingController edustartdateController;
  final TextEditingController eduenddateController;
  final TextEditingController edudescriptionController;
  final bool iseduCurrentPosition;
  final List<String> selectedSkills;
  final TextEditingController qualificationController;
  final TextEditingController qualificationdateController;
  final TextEditingController qualificationdescriptionController;

  // Initialize userUid in the constructor
  DashBoard({
    Key? key,
    required this.userUid,
    required this.fullNameController,
    required this.dobController,
    required this.emailController,
    required this.phoneNumberController,
    required this.selectedCountryCode,
    required this.links,
    required this.jobtitleController,
    required this.companyController,
    required this.isCurrentPosition,
    required this.workstartdateController,
    required this.workenddateController,
    required this.descriptionController,
    required this.degreeController,
    required this.edudescriptionController,
    required this.eduenddateController,
    required this.edustartdateController,
    required this.fieldofstudyController,
    required this.iseduCurrentPosition,
    required this.schoolController,
    required this.qualificationdescriptionController,
    required this.qualificationdateController,
    required this.qualificationController,
    required this.selectedSkills,
    required FirebaseAuth auth,
    required CollectionReference<Object?> users,
    required BuildContext context,
  }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userStream;

  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance
        .collection('User')
        .doc(widget.userUid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: userStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    String profileImageUrl =
                        userData['user_profileimage'] ?? '';

                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl)
                          : AssetImage('assets/default_image.jpg')
                              as ImageProvider, // Replace with your default image asset
                    );
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                '${widget.fullNameController.text}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateAboutPage(
                        userUid: widget.userUid!,
                        fullNameController: widget.fullNameController,
                        dobController: widget.dobController,
                        emailController: widget.emailController,
                        phoneNumberController: widget.phoneNumberController,
                        // Pass other necessary controllers and variables
                      ),
                    ),
                  );
                },
                child: Text('Update Profile'),
              ),
              ListTile(
                title: Text('About me'),
                trailing: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutMe()),
                  );
                },
              ),
              ListTile(
                title: Text('Work experience'),
                trailing: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkExperience()),
                  );
                },
              ),
              ListTile(
                title: Text('Education'),
                trailing: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Education()),
                  );
                },
              ),
              ListTile(
                title: Text('Skills'),
                trailing: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Skills()),
                  );
                },
              ),
              ListTile(
                title: Text('Qualifications'),
                trailing: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Qualifications()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
