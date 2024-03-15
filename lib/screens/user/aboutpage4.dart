import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'aboutpage5.dart';
import 'databaseConnection.dart';

class AboutPage4 extends StatefulWidget {
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

  const AboutPage4({
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
  }) : super(key: key);

  @override
  State<AboutPage4> createState() => _AboutPage4State();
}

class _AboutPage4State extends State<AboutPage4> {
  List<String> selectedSkills = [];
  List<String> filteredSkills = [];
  TextEditingController qualificationController = TextEditingController();
  TextEditingController qualificationdateController = TextEditingController();
  TextEditingController qualificationdescriptionController = TextEditingController();


  List<String> allSkills = [
    'Flutter','React.js','Dijango','WordPress'
    'Dart','User Interface Design','Frontend Development',
    'Firebase', 'UI/UX Design', 'Backend Development',
  ];

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
                  'Add Skills',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Search Bar
              TextField(
                onChanged: (query) {
                  setState(() {
                    filteredSkills = allSkills
                        .where((skill) =>
                        skill.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search Skills',
                  hintText: 'Enter a skill',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 10),
              // List of Skills
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredSkills[index]),
                      onTap: () {
                        setState(() {
                          selectedSkills.add(filteredSkills[index]);
                          // Optionally, remove the selected skill from the filtered list
                          // filteredSkills.remove(filteredSkills[index]);
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Display Selected Skills
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: selectedSkills
                    .map((skill) => Chip(
                  label: Text(skill),
                  onDeleted: () {
                    setState(() {
                      selectedSkills.remove(skill);
                      // Optionally, add the deleted skill back to the filtered list
                      // filteredSkills.add(skill);
                    });
                  },
                ))
                    .toList(),
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
                    selectedSkills: selectedSkills,
                    qualificationController: qualificationController,
                    qualificationdateController: qualificationdateController,
                    qualificationdescriptionController: qualificationdescriptionController,

                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage5(
                      userUid: widget.userUid,
                      fullNameController: widget.fullNameController,
                      dobController: widget.dobController,
                      emailController: widget.emailController,
                      phoneNumberController: widget.phoneNumberController,
                      selectedCountryCode: widget.selectedCountryCode,
                      links: widget.links,
                      jobtitleController: widget.jobtitleController,
                      companyController: widget.companyController,
                      isCurrentPosition: widget.isCurrentPosition,
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
                      selectedSkills: selectedSkills,


                    )), // Replace AboutPage2 with the actual page name
                  );

                },
                child: Text('Save & Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
