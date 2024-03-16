import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void addUserToFirestore({
  required BuildContext context, // Add this line to include the context
  required TextEditingController fullNameController,
  required TextEditingController dobController,
  required TextEditingController emailController,
  required TextEditingController phoneNumberController,
  required TextEditingController jobtitleController,
  required TextEditingController companyController,
  required bool isCurrentPosition,
  required TextEditingController workstartdateController,
  required TextEditingController workenddateController,
  required TextEditingController descriptionController,
  required bool iseduCurrentPosition,
  required TextEditingController schoolController,
  required TextEditingController degreeController,
  required TextEditingController fieldofstudyController,
  required TextEditingController edustartdateController,
  required TextEditingController eduenddateController,
  required TextEditingController edudescriptionController,
  required TextEditingController qualificationController,
  required TextEditingController qualificationdateController,
  required TextEditingController qualificationdescriptionController,
  required String selectedCountryCode,
  required List<String> links,
  required CollectionReference users,
  required FirebaseAuth auth,
  required List<String> selectedSkills,
  String? userUid,
}) async {
  try {
    if (userUid != null) {
      await users.doc(userUid).set({
        'user_fullname': fullNameController.text,
        'user_dob': dobController.text,
        'user_email': emailController.text,
        'user_mobile': '$selectedCountryCode${phoneNumberController.text}',
        'user_links': FieldValue.arrayUnion(links),
        'user_company': companyController.text,
        'user_jobtitle': jobtitleController.text,
        'user_work_iscurrentpos': isCurrentPosition,
        'user_work_startdate':workstartdateController.text,
        'user_work_enddate':workenddateController.text,
        'user_work_desc': descriptionController.text,
        'user_university':schoolController.text,
        'user_degree':degreeController.text,
        'user_fieldofstudy': fieldofstudyController.text,
        'user_edu_startdate': edustartdateController.text,
        'user_edu_enddate': eduenddateController.text,
        'user_edu_desc': edudescriptionController.text,
        'user_edu_iscurrentpos': iseduCurrentPosition,
        'user_skills':FieldValue.arrayUnion(selectedSkills),
        'user_qualification': qualificationController.text,
        'user_qua_date':qualificationdateController.text,
        'user_qua_desc': qualificationdescriptionController.text,


      });

      print('User data saved successfully!');
    } else {
      print('User UID is null. Unable to save user data.');
    }
  } catch (e) {
    print('Error saving user data: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to save user data. Please try again.'),
      ),
    );
  }
}
