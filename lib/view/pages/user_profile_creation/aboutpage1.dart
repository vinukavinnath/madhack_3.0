import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/custom_form_field.dart';
import 'package:async_and_await/view/pages/user_profile_creation/aboutpage2.dart';
import 'package:async_and_await/view/pages/user_profile_creation/databaseConnection.dart';

class AboutPage1 extends StatefulWidget {
  const AboutPage1({super.key});

  @override
  State<AboutPage1> createState() => _AboutPage1State();
}

class _AboutPage1State extends State<AboutPage1> {
  List<String> countryCodes = [
    '+1', // United States
    '+44', // United Kingdom
    '+91', // India
    '+94', // Sri Lanka
    // Add more country codes as needed
  ];

  String selectedCountryCode = '+1';
  List<String> links = [];

  TextEditingController fullNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController linksController = TextEditingController();
  TextEditingController jobtitleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  bool isCurrentPosition = false;
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

  String? userUid; // Store user email as document ID here

  @override
  void initState() {
    super.initState();
    getUserEmail().then((email) {
      setState(() {
        userUid = email;
      });
    });
  }

  Future<String?> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.email;
    } else {
      // Handle the case when the user is not signed in
      // You may want to redirect the user to the login screen
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Me',
          style: kHeading1TextStyle,
        ),
        centerTitle: true,
        elevation: 4.0,
        automaticallyImplyLeading: false,
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
                  title: 'Full Name',
                  hintText: 'John Doe',
                  controller: fullNameController,
                ),
                const SizedBox(height: 3),
                CustomFormField(
                  title: 'Date of Birth',
                  hintText: 'DD/MM/YYYY',
                  controller: dobController,
                ),
                CustomFormField(
                  title: 'Email',
                  hintText: 'someone@gmail.com',
                  controller: emailController,
                ),
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Phone Number',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              DropdownButton<String>(
                                value: selectedCountryCode,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCountryCode = newValue!;
                                  });
                                },
                                items:
                                    countryCodes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: CustomFormField(
                          title: ' ',
                          hintText: '761718545',
                          controller: phoneNumberController,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      title: 'Links',
                      hintText: 'https://madhack.ucscieee.lk/',
                      controller: linksController,
                    ),
                    const SizedBox(height: 16),
                    SecondaryButton(
                        title: 'Add more Links',
                        process: () {
                          if (linksController.text.isNotEmpty) {
                            setState(() {
                              links.add(linksController.text);
                              linksController.clear();
                            });
                          }
                        }),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (linksController.text.isNotEmpty) {
                    //       setState(() {
                    //         links.add(linksController.text);
                    //         linksController.clear();
                    //       });
                    //     }
                    //   },
                    //   child: const Text('Add More Links'),
                    // ),
                    const SizedBox(height: 10),
                    const Text(
                      'Added Links:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: links
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: const EdgeInsets.symmetric(),
                              child: Row(
                                children: [
                                  Text(
                                    entry.value,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 2),
                                  IconButton(
                                    icon: const Icon(Icons.highlight_remove),
                                    onPressed: () {
                                      setState(() {
                                        links.removeAt(entry.key);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     addUserToFirestore(
                //       context: context,
                //       fullNameController: fullNameController,
                //       dobController: dobController,
                //       emailController: emailController,
                //       phoneNumberController: phoneNumberController,
                //       selectedCountryCode: selectedCountryCode,
                //       jobtitleController:
                //           jobtitleController, // Fix the assignment here
                //       companyController: companyController,
                //       workstartdateController: workstartdateController,
                //       workenddateController: workenddateController,
                //       isCurrentPosition: isCurrentPosition,
                //       descriptionController: descriptionController,
                //       iseduCurrentPosition: iseduCurrentPosition,
                //       schoolController: schoolController,
                //       degreeController: degreeController,
                //       fieldofstudyController: fieldofstudyController,
                //       edustartdateController: edustartdateController,
                //       eduenddateController: eduenddateController,
                //       selectedSkills: selectedSkills,
                //       edudescriptionController: edudescriptionController,
                //       qualificationController: qualificationController,
                //       qualificationdateController: qualificationdateController,
                //       qualificationdescriptionController:
                //           qualificationdescriptionController,
                //       links: links, // Pass the links list directly
                //       users: users,
                //       auth: FirebaseAuth.instance,
                //       userUid: userUid,
                //     );
                //     // Navigate to AboutPage2 after saving data
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AboutPage2(
                //                 userUid: userUid,
                //                 fullNameController: fullNameController,
                //                 dobController: dobController,
                //                 emailController: emailController,
                //                 phoneNumberController: phoneNumberController,
                //                 selectedCountryCode: selectedCountryCode,
                //                 links: links,
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
                      fullNameController: fullNameController,
                      dobController: dobController,
                      emailController: emailController,
                      phoneNumberController: phoneNumberController,
                      selectedCountryCode: selectedCountryCode,
                      jobtitleController:
                          jobtitleController, // Fix the assignment here
                      companyController: companyController,
                      workstartdateController: workstartdateController,
                      workenddateController: workenddateController,
                      isCurrentPosition: isCurrentPosition,
                      descriptionController: descriptionController,
                      iseduCurrentPosition: iseduCurrentPosition,
                      schoolController: schoolController,
                      degreeController: degreeController,
                      fieldofstudyController: fieldofstudyController,
                      edustartdateController: edustartdateController,
                      eduenddateController: eduenddateController,
                      selectedSkills: selectedSkills,
                      edudescriptionController: edudescriptionController,
                      qualificationController: qualificationController,
                      qualificationdateController: qualificationdateController,
                      qualificationdescriptionController:
                          qualificationdescriptionController,
                      links: links, // Pass the links list directly
                      users: users,
                      auth: FirebaseAuth.instance,
                      userUid: userUid,
                    );
                    // Navigate to AboutPage2 after saving data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage2(
                          userUid: userUid,
                          fullNameController: fullNameController,
                          dobController: dobController,
                          emailController: emailController,
                          phoneNumberController: phoneNumberController,
                          selectedCountryCode: selectedCountryCode,
                          links: links,
                        ),
                      ), // Replace AboutPage2 with the actual page name
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
