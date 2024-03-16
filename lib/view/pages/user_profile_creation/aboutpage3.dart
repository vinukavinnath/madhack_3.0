import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:async_and_await/view/widgets/custom_form_field.dart';
import 'aboutpage4.dart';
import 'databaseConnection.dart';

class AboutPage3 extends StatefulWidget {
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

  const AboutPage3({
    super.key,
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
  });

  @override
  State<AboutPage3> createState() => _AboutPage2State();
}

class _AboutPage2State extends State<AboutPage3> {
  TextEditingController jobtitleController = TextEditingController();
  bool iseduCurrentPosition = false;
  TextEditingController schoolController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
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
            'Add Education',
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
        body: Container(
          height: screenHeight,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/noise.webp',
                ),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                CustomFormField(
                  title: 'Institute/School',
                  hintText: 'Monash University',
                  controller: schoolController,
                ),
                const SizedBox(height: 3),
                CustomFormField(
                  title: 'Degree',
                  hintText: 'Bachelor',
                  controller: degreeController,
                ),
                CustomFormField(
                  title: 'Field of Study',
                  hintText: 'Computer science',
                  controller: fieldofstudyController,
                ),

                // Use Container instead of Expanded
                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        title: 'Start Date',
                        hintText: 'DD/MM/YYYY',
                        controller: edustartdateController,
                      ),
                    ),
                    const SizedBox(width: 10), // Adjust the width as needed
                    Expanded(
                      child: CustomFormField(
                        title: 'End Date',
                        hintText: 'DD/MM/YYYY',
                        controller: eduenddateController,
                      ),
                    ),
                  ],
                ),

                // Checkbox for indicating current position
                Row(
                  children: [
                    Checkbox(
                      value: iseduCurrentPosition,
                      onChanged: (value) {
                        setState(() {
                          iseduCurrentPosition = value ?? false;
                        });
                      },
                    ),
                    const Text('This is my current position'),
                  ],
                ),

                CustomFormField(
                  title: 'Description',
                  hintText: 'Lorem Ipsum is ....',
                  controller: edudescriptionController,
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
                //       isCurrentPosition: widget.isCurrentPosition,
                //       users: users,
                //       auth: FirebaseAuth.instance,
                //       userUid: widget.userUid!,
                //       selectedCountryCode: widget.selectedCountryCode,
                //       links: widget.links,
                //       jobtitleController: widget.jobtitleController,
                //       companyController: widget.companyController,
                //       workstartdateController: widget.workstartdateController,
                //       workenddateController: widget.workenddateController,
                //       descriptionController: widget.descriptionController,
                //       schoolController: schoolController,
                //       degreeController: degreeController,
                //       fieldofstudyController: fieldofstudyController,
                //       edustartdateController: edustartdateController,
                //       eduenddateController: eduenddateController,
                //       edudescriptionController: edudescriptionController,
                //       iseduCurrentPosition: iseduCurrentPosition,
                //       selectedSkills: selectedSkills,
                //       qualificationController: qualificationController,
                //       qualificationdateController: qualificationdateController,
                //       qualificationdescriptionController:
                //           qualificationdescriptionController,
                //     );
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AboutPage4(
                //                 userUid: widget.userUid,
                //                 fullNameController: widget.fullNameController,
                //                 dobController: widget.dobController,
                //                 emailController: widget.emailController,
                //                 phoneNumberController:
                //                     widget.phoneNumberController,
                //                 selectedCountryCode: widget.selectedCountryCode,
                //                 links: widget.links,
                //                 jobtitleController: widget.jobtitleController,
                //                 companyController: widget.companyController,
                //                 isCurrentPosition: widget.isCurrentPosition,
                //                 workstartdateController:
                //                     widget.workstartdateController,
                //                 workenddateController:
                //                     widget.workenddateController,
                //                 descriptionController:
                //                     widget.descriptionController,
                //                 schoolController: schoolController,
                //                 degreeController: degreeController,
                //                 fieldofstudyController: fieldofstudyController,
                //                 edustartdateController: edustartdateController,
                //                 eduenddateController: eduenddateController,
                //                 edudescriptionController:
                //                     edudescriptionController,
                //                 iseduCurrentPosition: iseduCurrentPosition,
                //               )), // Replace AboutPage2 with the actual page name
                //     );
                //   },
                //   child: Text('Save & Next'),
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
                        schoolController: schoolController,
                        degreeController: degreeController,
                        fieldofstudyController: fieldofstudyController,
                        edustartdateController: edustartdateController,
                        eduenddateController: eduenddateController,
                        edudescriptionController: edudescriptionController,
                        iseduCurrentPosition: iseduCurrentPosition,
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
                            builder: (context) => AboutPage4(
                                  userUid: widget.userUid,
                                  fullNameController: widget.fullNameController,
                                  dobController: widget.dobController,
                                  emailController: widget.emailController,
                                  phoneNumberController:
                                      widget.phoneNumberController,
                                  selectedCountryCode:
                                      widget.selectedCountryCode,
                                  links: widget.links,
                                  jobtitleController: widget.jobtitleController,
                                  companyController: widget.companyController,
                                  isCurrentPosition: widget.isCurrentPosition,
                                  workstartdateController:
                                      widget.workstartdateController,
                                  workenddateController:
                                      widget.workenddateController,
                                  descriptionController:
                                      widget.descriptionController,
                                  schoolController: schoolController,
                                  degreeController: degreeController,
                                  fieldofstudyController:
                                      fieldofstudyController,
                                  edustartdateController:
                                      edustartdateController,
                                  eduenddateController: eduenddateController,
                                  edudescriptionController:
                                      edudescriptionController,
                                  iseduCurrentPosition: iseduCurrentPosition,
                                )), // Replace AboutPage2 with the actual page name
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
