import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:async_and_await/view/widgets/custom_form_field.dart';
import 'aboutpage3.dart';
import 'databaseConnection.dart';

class AboutPage2 extends StatefulWidget {
  final String? userUid;
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final String selectedCountryCode;
  final List<String> links;

  const AboutPage2({
    super.key,
    required this.userUid,
    required this.fullNameController,
    required this.dobController,
    required this.emailController,
    required this.phoneNumberController,
    required this.selectedCountryCode,
    required this.links,
  });

  @override
  State<AboutPage2> createState() => _AboutPage2State();
}

class _AboutPage2State extends State<AboutPage2> {
  TextEditingController jobtitleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  bool isCurrentPosition = false; // Add a variable to track the checkbox state
  TextEditingController workstartdateController = TextEditingController();
  TextEditingController workenddateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  bool iseduCurrentPosition = false;
  TextEditingController fieldofstudyController = TextEditingController();
  TextEditingController edustartdateController = TextEditingController();
  TextEditingController eduenddateController = TextEditingController();
  TextEditingController edudescriptionController = TextEditingController();
  List<String> selectedSkills = [];
  TextEditingController qualificationController = TextEditingController();
  TextEditingController qualificationdateController = TextEditingController();
  TextEditingController qualificationdescriptionController =
      TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Work Experience',
            style: kHeading1TextStyle,
          ),
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
        body: Container(
          height: screenHeight,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/noise.webp',
                ),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomFormField(
                    title: 'Job Title',
                    hintText: 'Manager',
                    controller: jobtitleController,
                  ),
                  const SizedBox(height: 3),
                  CustomFormField(
                    title: 'Company',
                    hintText: 'ABC Dev Solution',
                    controller: companyController,
                  ),

                  // Use Container instead of Expanded
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormField(
                          title: 'Start Date',
                          hintText: 'DD/MM/YYYY',
                          controller: workstartdateController,
                        ),
                      ),
                      const SizedBox(width: 10), // Adjust the width as needed
                      Expanded(
                        child: CustomFormField(
                          title: 'End Date',
                          hintText: 'DD/MM/YYYY',
                          controller: workenddateController,
                        ),
                      ),
                    ],
                  ),

                  // Checkbox for indicating current position
                  Row(
                    children: [
                      Checkbox(
                        value: isCurrentPosition,
                        onChanged: (value) {
                          setState(() {
                            isCurrentPosition = value ?? false;
                          });
                        },
                      ),
                      const Text('This is my current position'),
                    ],
                  ),

                  CustomFormField(
                    title: 'Description',
                    hintText: 'Lorem Ipsum is ....',
                    controller: descriptionController,
                  ),

                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     addUserToFirestore(
                  //       context: context,
                  //       fullNameController: widget.fullNameController,
                  //       dobController: widget.dobController,
                  //       emailController: widget.emailController,
                  //       phoneNumberController: widget.phoneNumberController,
                  //       isCurrentPosition:
                  //           isCurrentPosition, // Pass the checkbox value
                  //       users: users,
                  //       auth: FirebaseAuth.instance,
                  //       userUid: widget.userUid!,
                  //       selectedCountryCode: widget.selectedCountryCode,
                  //       links: widget.links,
                  //       jobtitleController: jobtitleController,
                  //       companyController: companyController,
                  //       workstartdateController: workstartdateController,
                  //       workenddateController: workenddateController,
                  //       descriptionController: descriptionController,
                  //       iseduCurrentPosition: iseduCurrentPosition,
                  //       schoolController: schoolController,
                  //       degreeController: degreeController,
                  //       fieldofstudyController: fieldofstudyController,
                  //       edustartdateController: edustartdateController,
                  //       eduenddateController: eduenddateController,
                  //       edudescriptionController: edudescriptionController,
                  //       selectedSkills: selectedSkills,
                  //       qualificationController: qualificationController,
                  //       qualificationdateController: qualificationdateController,
                  //       qualificationdescriptionController:
                  //           qualificationdescriptionController,
                  //     );
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => AboutPage3(
                  //                 userUid: widget.userUid,
                  //                 fullNameController: widget.fullNameController,
                  //                 dobController: widget.dobController,
                  //                 emailController: widget.emailController,
                  //                 phoneNumberController:
                  //                     widget.phoneNumberController,
                  //                 selectedCountryCode: widget.selectedCountryCode,
                  //                 links: widget.links,
                  //                 jobtitleController: jobtitleController,
                  //                 companyController: companyController,
                  //                 isCurrentPosition: isCurrentPosition,
                  //                 workstartdateController:
                  //                     workstartdateController,
                  //                 workenddateController: workenddateController,
                  //                 descriptionController: descriptionController,
                  //               )), // Replace AboutPage2 with the actual page name
                  //     );
                  //   },
                  //   child: const Text('Save & Next'),
                  // ),
                  PrimaryButton(
                      title: 'Save & Next',
                      process: () {
                        addUserToFirestore(
                          context: context,
                          fullNameController: widget.fullNameController,
                          dobController: widget.dobController,
                          emailController: widget.emailController,
                          phoneNumberController: widget.phoneNumberController,
                          isCurrentPosition:
                              isCurrentPosition, // Pass the checkbox value
                          users: users,
                          auth: FirebaseAuth.instance,
                          userUid: widget.userUid!,
                          selectedCountryCode: widget.selectedCountryCode,
                          links: widget.links,
                          jobtitleController: jobtitleController,
                          companyController: companyController,
                          workstartdateController: workstartdateController,
                          workenddateController: workenddateController,
                          descriptionController: descriptionController,
                          iseduCurrentPosition: iseduCurrentPosition,
                          schoolController: schoolController,
                          degreeController: degreeController,
                          fieldofstudyController: fieldofstudyController,
                          edustartdateController: edustartdateController,
                          eduenddateController: eduenddateController,
                          edudescriptionController: edudescriptionController,
                          selectedSkills: selectedSkills,
                          qualificationController: qualificationController,
                          qualificationdateController:
                              qualificationdateController,
                          qualificationdescriptionController:
                              qualificationdescriptionController,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutPage3(
                                    userUid: widget.userUid,
                                    fullNameController:
                                        widget.fullNameController,
                                    dobController: widget.dobController,
                                    emailController: widget.emailController,
                                    phoneNumberController:
                                        widget.phoneNumberController,
                                    selectedCountryCode:
                                        widget.selectedCountryCode,
                                    links: widget.links,
                                    jobtitleController: jobtitleController,
                                    companyController: companyController,
                                    isCurrentPosition: isCurrentPosition,
                                    workstartdateController:
                                        workstartdateController,
                                    workenddateController:
                                        workenddateController,
                                    descriptionController:
                                        descriptionController,
                                  )), // Replace AboutPage2 with the actual page name
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
