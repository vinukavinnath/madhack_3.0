import 'package:async_and_await/screens/user/dashboard/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/CustomFormField.dart';
import 'aboutpage5.dart';
import 'databaseConnection.dart';

class AboutPage5 extends StatefulWidget {
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

  const AboutPage5({
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
    required this.selectedSkills,
  }) : super(key: key);

  @override
  State<AboutPage5> createState() => _AboutPage5State();
}

class _AboutPage5State extends State<AboutPage5> {
  TextEditingController qualificationController = TextEditingController();
  TextEditingController qualificationdateController = TextEditingController();
  TextEditingController qualificationdescriptionController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Add Qualification',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomFormField(
                title: 'Qualification',
                hintText: 'Monash University',
                controller: qualificationController,
              ),
              CustomFormField(
                title: 'Date',
                hintText: 'DD/MM/YYYY',
                controller: qualificationdateController,
              ),
              CustomFormField(
                title: 'Description',
                hintText: 'lorem Ipsum is....',
                controller: qualificationdescriptionController,
              ),


              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addUserToFirestore(
                    context: context,
                    fullNameController: widget.fullNameController,
                    dobController: widget.dobController,
                    emailController: widget.emailController,
                    phoneNumberController: widget.phoneNumberController,
                    isCurrentPosition: widget.isCurrentPosition,
                    users: users,
                    auth: FirebaseAuth.instance,
                    userUid: widget.userUid!,
                    selectedCountryCode: widget.selectedCountryCode,
                    links: widget.links,
                    jobtitleController: widget.jobtitleController,
                    companyController: widget.companyController,
                    workstartdateController: widget.workstartdateController,
                    workenddateController: widget.workenddateController,
                    descriptionController: widget.descriptionController,
                    schoolController: widget.schoolController,
                    degreeController: widget.degreeController,
                    fieldofstudyController: widget.fieldofstudyController,
                    edustartdateController:widget.edustartdateController,
                    eduenddateController: widget.eduenddateController,
                    edudescriptionController: widget.edudescriptionController,
                    iseduCurrentPosition: widget.iseduCurrentPosition,
                    selectedSkills: widget.selectedSkills,
                    qualificationController: qualificationController,
                    qualificationdateController: qualificationdateController,
                    qualificationdescriptionController: qualificationdescriptionController,
                  );
                  // Move Navigator.push outside the addUserToFirestore function
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashBoard(
                      userUid: widget.userUid,
                      context: context,
                      fullNameController: widget.fullNameController,
                      dobController: widget.dobController,
                      emailController: widget.emailController,
                      phoneNumberController: widget.phoneNumberController,
                      isCurrentPosition: widget.isCurrentPosition,
                      users: users,
                      auth: FirebaseAuth.instance,
                      selectedCountryCode: widget.selectedCountryCode,
                      links: widget.links,
                      jobtitleController: widget.jobtitleController,
                      companyController: widget.companyController,
                      workstartdateController: widget.workstartdateController,
                      workenddateController: widget.workenddateController,
                      descriptionController: widget.descriptionController,
                      schoolController: widget.schoolController,
                      degreeController: widget.degreeController,
                      fieldofstudyController: widget.fieldofstudyController,
                      edustartdateController:widget.edustartdateController,
                      eduenddateController: widget.eduenddateController,
                      edudescriptionController: widget.edudescriptionController,
                      iseduCurrentPosition: widget.iseduCurrentPosition,
                      selectedSkills: widget.selectedSkills,
                      qualificationController: qualificationController,
                      qualificationdateController: qualificationdateController,
                      qualificationdescriptionController: qualificationdescriptionController,
                    )),
                  );
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
