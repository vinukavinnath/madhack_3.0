import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'salary.dart';

class Location extends StatefulWidget {
  final String docId;
  final String industry;
  final String category;
  final String jobposition;
  final String jobtype;
  final String workspace;
  final String minSalary;
  final String maxSalary;
  final String jobdes;
  final String requirements;
  final String resposibilities;
  final String aboutcomp;
  final String compname;
  final String compprofileimage;

  const Location({
    Key? key,
    required this.docId,
    required this.industry,
    required this.category,
    required this.jobposition,
    required this.jobtype,
    required this.workspace,
    required this.minSalary,
    required this.maxSalary,
    required this.aboutcomp,
    required this.resposibilities,
    required this.requirements,
    required this.jobdes,
    required this.compname,
    required this.compprofileimage,
  }) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String selectedLocation = ''; // Selected location variable

  final List<String> allLocations = [
    'Colombo/Western Province',
    'Gampaha/Western Province',
    'Kalutara/Western Province',
    'Kandy/Central Province',
    'Matale/Central Province',
    'Nuwara Eliya/Central Province',
    'Galle/Southern Province',
    'Matara/Southern Province',
    'Hambantota/Southern Province',
    'Jaffna/Northern Province',
    'Mannar/Northern Province',
    'Vavuniya/Northern Province',
    'Mullaitivu/Northern Province',
    'Kilinochchi/Northern Province',
    'Batticaloa/Eastern Province',
    'Ampara/Eastern Province',
    'Trincomalee/Eastern Province',
    'Kurunegala/North Western Province',
    'Puttalam/North Western Province',
    'Anuradhapura/North Western Province',
    'Polonnaruwa/North Western Province',
    'Badulla/Uva Province',
    'Moneragala/Uva Province',
    'Ratnapura/Sabaragamuwa Province',
    'Kegalle/Sabaragamuwa Province',
  ];

  List<String> filteredLocations =
      []; // Filtered location list based on search query

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Location',
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Search Bar
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        filteredLocations = allLocations
                            .where((location) => location
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search location...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display filtered locations
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredLocations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredLocations[index]),
                        onTap: () {
                          setState(() {
                            selectedLocation = filteredLocations[index];
                          });
                          // Navigate to Salary.dart page or perform any other action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Salary(
                                docId: widget.docId,
                                industry: widget.industry,
                                category: widget.category,
                                jobposition: widget.jobposition,
                                jobtype: widget.jobtype,
                                workspace: widget.workspace,
                                minSalary: widget.minSalary,
                                maxSalary: widget.maxSalary,
                                aboutcomp: widget.aboutcomp,
                                resposibilities: widget.resposibilities,
                                requirements: widget.requirements,
                                jobdes: widget.jobdes,
                                compname: widget.compname,
                                selectedLocation: selectedLocation,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  PrimaryButton(
                    process: () {
                      // Navigate to Salary.dart page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Salary(
                            docId: widget.docId,
                            industry: widget.industry,
                            category: widget.category,
                            jobposition: widget.jobposition,
                            jobtype: widget.jobtype,
                            workspace: widget.workspace,
                            minSalary: widget.minSalary,
                            maxSalary: widget.maxSalary,
                            aboutcomp: widget.aboutcomp,
                            resposibilities: widget.resposibilities,
                            requirements: widget.requirements,
                            jobdes: widget.jobdes,
                            compname: widget.compname,
                            selectedLocation: selectedLocation,
                          ),
                        ),
                      );
                    },
                    title:'Next',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
