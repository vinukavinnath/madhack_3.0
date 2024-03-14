import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'location.dart';

class FirebaseOperations {
  static Future<void> addDataToFirebase(
      BuildContext context,
      String userEmail, // Modified to accept user's email as doc ID
      String industry,
      String category,
      String jobposition,
      String jobtype,
      String workspace,
      ) async {
    try {
      await Firebase.initializeApp();
      CollectionReference jobs = FirebaseFirestore.instance.collection('Jobs');

      // Using the user's email as the document ID
      await jobs.doc(userEmail).set({
        'emp_industry': industry,
        'emp_category': category,
        'emp_Job_Position': jobposition,
        'emp_jobtype':jobtype,
        'emp_workspace':workspace,

      });

      // If successful, navigate to another screen
      // Replace 'Location' with your desired destination
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Location()),
      );
    } catch (e) {
      print("Error adding data to Firestore: $e");
    }
  }
}
