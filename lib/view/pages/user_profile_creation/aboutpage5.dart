import 'package:async_and_await/constants.dart';
import 'package:async_and_await/screens/user/dashboard/dashboard.dart';
import 'package:async_and_await/view/pages/home_page_applicant.dart';
import 'package:async_and_await/view/widgets/hidden_drawer_user.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:async_and_await/view/widgets/custom_form_field.dart';
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
    required this.degreeController,
    required this.edudescriptionController,
    required this.eduenddateController,
    required this.edustartdateController,
    required this.fieldofstudyController,
    required this.iseduCurrentPosition,
    required this.schoolController,
    required this.selectedSkills,
  });

  @override
  State<AboutPage5> createState() => _AboutPage5State();
}

class _AboutPage5State extends State<AboutPage5> {
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
                const SizedBox(height: 20),
                PrimaryButton(
                  title: 'Save & ',
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
                      schoolController: widget.schoolController,
                      degreeController: widget.degreeController,
                      fieldofstudyController: widget.fieldofstudyController,
                      edustartdateController: widget.edustartdateController,
                      eduenddateController: widget.eduenddateController,
                      edudescriptionController: widget.edudescriptionController,
                      iseduCurrentPosition: widget.iseduCurrentPosition,
                      selectedSkills: widget.selectedSkills,
                      qualificationController: qualificationController,
                      qualificationdateController: qualificationdateController,
                      qualificationdescriptionController:
                          qualificationdescriptionController,
                    );
                    // Move Navigator.push outside the addUserToFirestore function
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HiddenDrawer(),
                        //     DashBoard(
                        //   userUid: widget.userUid,
                        //   context: context,
                        //   fullNameController: widget.fullNameController,
                        //   dobController: widget.dobController,
                        //   emailController: widget.emailController,
                        //   phoneNumberController: widget.phoneNumberController,
                        //   isCurrentPosition: widget.isCurrentPosition,
                        //   users: users,
                        //   auth: FirebaseAuth.instance,
                        //   selectedCountryCode: widget.selectedCountryCode,
                        //   links: widget.links,
                        //   jobtitleController: widget.jobtitleController,
                        //   companyController: widget.companyController,
                        //   workstartdateController:
                        //       widget.workstartdateController,
                        //   workenddateController: widget.workenddateController,
                        //   descriptionController: widget.descriptionController,
                        //   schoolController: widget.schoolController,
                        //   degreeController: widget.degreeController,
                        //   fieldofstudyController: widget.fieldofstudyController,
                        //   edustartdateController: widget.edustartdateController,
                        //   eduenddateController: widget.eduenddateController,
                        //   edudescriptionController:
                        //       widget.edudescriptionController,
                        //   iseduCurrentPosition: widget.iseduCurrentPosition,
                        //   selectedSkills: widget.selectedSkills,
                        //   qualificationController: qualificationController,
                        //   qualificationdateController:
                        //       qualificationdateController,
                        //   qualificationdescriptionController:
                        //       qualificationdescriptionController,
                        // ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
