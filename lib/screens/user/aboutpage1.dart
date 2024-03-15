import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/CustomFormField.dart';
import 'aboutpage2.dart';
import 'databaseConnection.dart';

class AboutPage1 extends StatefulWidget {
  const AboutPage1({Key? key}) : super(key: key);

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
  TextEditingController qualificationdescriptionController = TextEditingController();



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
                  'About Me',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomFormField(
                title: 'Full Name',
                hintText: 'Vinuka Vinnath',
                controller: fullNameController,
              ),
              SizedBox(height: 3),
              CustomFormField(
                title: 'Date of Birth',
                hintText: 'DD/MM/YYYY',
                controller: dobController,
              ),
              CustomFormField(
                title: 'Email',
                hintText: 'vinukavinnath@gmail.com',
                controller: emailController,
              ),
              SizedBox(height: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                              items: countryCodes.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                            ),
                            SizedBox(width: 5),
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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      title: 'Links',
                      hintText: 'https://madhack.ucscieee.lk/',
                      controller: linksController,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (linksController.text.isNotEmpty) {
                          setState(() {
                            links.add(linksController.text);
                            linksController.clear();
                          });
                        }
                      },
                      child: Text('Add More Links'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Added Links:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: links.asMap().entries.map(
                            (entry) => Padding(
                          padding: const EdgeInsets.symmetric( ),
                          child: Row(
                            children: [
                              Text(
                                entry.value,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(width: 2),
                              IconButton(
                                icon: Icon(Icons.highlight_remove),
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
              ),


              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addUserToFirestore(
                    context: context,
                    fullNameController: fullNameController,
                    dobController: dobController,
                    emailController: emailController,
                    phoneNumberController: phoneNumberController,
                    selectedCountryCode: selectedCountryCode,
                    jobtitleController: jobtitleController, // Fix the assignment here
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
                    qualificationdescriptionController: qualificationdescriptionController,
                    links: links, // Pass the links list directly
                    users: users,
                    auth: FirebaseAuth.instance,
                    userUid: userUid,
                  );
                  // Navigate to AboutPage2 after saving data
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage2(
                      userUid: userUid,
                      fullNameController: fullNameController,
                      dobController: dobController,
                      emailController: emailController,
                      phoneNumberController: phoneNumberController,
                      selectedCountryCode: selectedCountryCode,
                      links: links,

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
