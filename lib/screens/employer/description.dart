import 'package:flutter/material.dart';
import 'Location.dart';
import 'databaseconnectionemp.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final industryController = TextEditingController();
  final categoryController = TextEditingController();
  final jobpositionController = TextEditingController();
  final minSalaryController = TextEditingController();
  final maxSalaryController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final requirementsController = TextEditingController();
  final responsibilitiesController = TextEditingController();
  final aboutCompanyController = TextEditingController();
  final companynameController = TextEditingController();
  final companyProfileImageController = TextEditingController();
  String selectedLocation = ''; // Selected location variable

  String selectedIndustry = 'Software Development Industry';
  List<String> industries = [
    'Software Development Industry',
    'Information Technology (IT) Services Industry',
    'Web Development Industry',
    'Data Science and Analytics Industry',
    'Cybersecurity Industry',
    'UI/UX Design Industry',
    'Software Testing and Quality Assurance Industry',
    'Project Management Industry',
    'Artificial Intelligence (AI) Industry',
    'Mobile App Development'
  ];

  String selectedCategory = 'Software Engineer/Developer';
  Map<String, List<String>> categoryMap = {
    'Software Development Industry': [
      'Software Engineer/Developer',
      'Full-Stack Developer',
      'Front-End Developer',
      'Back-End Developer',
      'Mobile App Developer',
      'Game Developer',
      'DevOps Engineer',
      'Quality Assurance (QA) Engineer'
    ],
    'Information Technology (IT) Services Industry': [
      'IT Support Specialist',
      'Network Engineer',
      'System Administrator',
      'IT Security Analyst',
      'Database Administrator',
      'Cloud Solutions Architect',
      'IT Project Manager'
    ],
    'Web Development Industry': [
      'Web Designer',
      'Web Developer',
      'E-commerce Developer',
      'CMS Developer',
      'Web Accessibility Specialist'
    ],
    'Data Science and Analytics Industry': [
      'Data Scientist',
      'Data Analyst',
      'BI Analyst',
      'Data Engineer',
      'Machine Learning Engineer',
      'Big Data Specialist'
    ],
    'Cybersecurity Industry': [
      'Cybersecurity Analyst',
      'Information Security Specialist',
      'Ethical Hacker',
      'SOC Analyst',
      'Security Consultant'
    ],
    'UI/UX Design Industry': [
      'UI Designer',
      'UX Designer',
      'Interaction Designer',
      'User Researcher',
      'Product Designer'
    ],
    'Software Testing and Quality Assurance Industry': [
      'QA Tester',
      'Test Automation Engineer',
      'QA Analyst',
      'Performance Testing Engineer',
      'Software Quality Assurance Manager'
    ],
    'Project Management Industry': [
      'IT Project Manager',
      'Scrum Master',
      'Agile Coach',
      'Product Owner'
    ],
    'Artificial Intelligence (AI) Industry': [
      'AI Engineer',
      'Machine Learning Engineer',
      'NLP Engineer',
      'Computer Vision Engineer',
      'AI Research Scientist'
    ],
    'Mobile App Development': [
      'iOS Developer',
      'Android Developer',
      'Cross-Platform Mobile Developer',
      'Mobile App Tester',
      'Mobile Product Manager'
    ],
  };

  String selectedJobType = 'Full Time';
  List<String> jobTypes = ['Full Time', 'Remote', 'Internship', 'Contract'];

  String selectedWorkspace = 'On-Site';
  Map<String, List<String>> workspaceMap = {
    'Full Time': ['On-Site'],
    'Remote': ['Remote', 'Co-working Space'],
    'Internship': ['On-Site'],
    'Contract': ['Client Site', 'On-Site'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: SizedBox(
                      width: 200, // Adjust width as needed
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedIndustry = value!;
                    selectedCategory = categoryMap[selectedIndustry]![0];
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Industry',
                ),
              ),

              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categoryMap[selectedIndustry]!.map((String value) {
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
                value: selectedJobType,
                items: jobTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedJobType = value!;
                    selectedWorkspace = workspaceMap[selectedJobType]![0];
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Job Type',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedWorkspace,
                items: workspaceMap[selectedJobType]!.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedWorkspace = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Workspace',
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  String docId = UniqueKey().toString();
                  String minSalary = minSalaryController.text;
                  String maxSalary = maxSalaryController.text;

                  FirebaseOperations.addDataToFirebase(
                    context,
                    docId,
                    selectedIndustry,
                    selectedCategory,
                    jobpositionController.text,
                    selectedJobType,
                    selectedWorkspace,
                    minSalary,
                    maxSalary,
                    jobDescriptionController.text,
                    requirementsController.text,
                    responsibilitiesController.text,
                    aboutCompanyController.text,
                    companynameController.text,
                    companyProfileImageController.text,
                    selectedLocation,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Location(
                        docId: docId,
                        industry: selectedIndustry,
                        category: selectedCategory,
                        jobposition: jobpositionController.text,
                        jobtype: selectedJobType,
                        workspace: selectedWorkspace,
                        minSalary: minSalary,
                        maxSalary: maxSalary,
                        jobdes: jobDescriptionController.text,
                        requirements: requirementsController.text,
                        resposibilities: responsibilitiesController.text,
                        aboutcomp: aboutCompanyController.text,
                        compname: companynameController.text,
                        compprofileimage: companyProfileImageController.text,
                      ),
                    ),
                  );
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
