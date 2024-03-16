import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseOperations {
  static Future<void> addDataToFirebase(
      BuildContext context,
      String docId, // Accept docId parameter
      String industry,
      String category,
      String jobposition,
      String jobtype,
      String workspace,
      String selectedLocation,
      String minSalary, // Add parameters for minSalary and maxSalary
      String maxSalary,
      String jobdes,
      String requirements,
      String responsibilities,
      String compname,
      String aboutcomp,
      String compprofileimage,
      ) async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp();
      CollectionReference jobs = FirebaseFirestore.instance.collection('Jobs');

      // Get the current user's UID
      User? user = FirebaseAuth.instance.currentUser;
      String? uid = user?.uid;

      // Set data to Firestore using provided docId
      await jobs.doc(docId).set({
        'emp_uid': uid,
        'emp_industry': industry,
        'emp_category': category,
        'emp_Job_Position': jobposition,
        'emp_jobtype': jobtype,
        'emp_workspace': workspace,
        'emp_location': selectedLocation,
        'emp_min_Salary': minSalary, // Add minSalary to Firestore
        'emp_max_Salary': maxSalary, // Add maxSalary to Firestore
        'emp_job_des': jobdes,
        'emp_requirements': requirements, // Corrected typo in field name
        'emp_responsibilities': responsibilities, // Corrected typo in field name
        'emp_comp_name': compname,
        'emp_about_comp': aboutcomp,
        'emp_profile_img': compprofileimage,
      });
    } catch (e) {
      print("Error adding data to Firestore: $e");
    }
  }
}