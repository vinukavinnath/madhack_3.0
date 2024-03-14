import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'databaseconnectionemp.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final industryController = TextEditingController();
  final categoryController = TextEditingController();
  final jobpositionController = TextEditingController();

  String selectedIndustry = 'Design & Development';
  List<String> industries = ['Design & Development', 'Testing', 'Other Industry'];

  String selectedCategory = 'UI/UX Design';
  List<String> Categories = ['UI/UX Design', 'Frontend Design', 'Other Industry'];

  String selectedjobtype = 'Full Time';
  List<String> jobtype = ['Full Time', 'Half Time', 'Other jobtype'];

  String selectedworkspace = 'On-Site';
  List<String> workspace = ['On-Site', 'online', 'Other workspace'];

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap with Scaffold to ensure Material widget
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: selectedIndustry,
                items: industries.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedIndustry = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Industry',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: Categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jobpositionController,
                decoration: InputDecoration(
                  labelText: 'Job Position',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedjobtype,
                items: jobtype.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedjobtype = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jobtype',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedworkspace,
                items: workspace.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedworkspace = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jobtype',
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  // Get the current user's UID
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // Get the email associated with the user's UID
                    String? email = user.email;
                    if (email != null) {
                      // Call FirebaseOperations method to add data to Firestore
                      FirebaseOperations.addDataToFirebase(
                        context,
                        email, // Pass user's email as doc ID
                        selectedIndustry,
                        selectedCategory,
                        jobpositionController.text,
                        selectedjobtype,
                        selectedworkspace,
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

