import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'databaseconnectionemp.dart';
import 'details.dart';

class Salary extends StatefulWidget {
  final String docId;
  final String industry;
  final String category;
  final String jobposition;
  final String jobtype;
  final String workspace;
  final String selectedLocation;
  final String minSalary;
  final String maxSalary;
  final String jobdes;
  final String requirements;
  final String resposibilities;
  final String aboutcomp;
  final String compname;

  const Salary({
    Key? key,
    required this.docId,
    required this.industry,
    required this.category,
    required this.jobposition,
    required this.jobtype,
    required this.workspace,
    required this.selectedLocation,
    required this.minSalary,
    required this.maxSalary,
    required this.aboutcomp,
    required this.resposibilities,
    required this.requirements,
    required this.jobdes,
    required this.compname,
  }) : super(key: key);

  @override
  State<Salary> createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
  double currentSalary = 5000; // Initial salary value
  double minSalary = 10; // Initial min salary value for range slider
  double maxSalary = 500; // Initial max salary value for range slider

  late TextEditingController minSalaryController;
  late TextEditingController maxSalaryController;

  @override
  void initState() {
    super.initState();
    minSalaryController = TextEditingController(text: minSalary.toString());
    maxSalaryController = TextEditingController(text: maxSalary.toString());
  }

  @override
  void dispose() {
    minSalaryController.dispose();
    maxSalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FlutterSlider(
              values: [minSalary, maxSalary],
              rangeSlider: true,
              min: 10,
              max: 3000,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {
                  minSalary = lowerValue;
                  maxSalary = upperValue;
                  minSalaryController.text = minSalary.toStringAsFixed(2);
                  maxSalaryController.text = maxSalary.toStringAsFixed(2);
                });
              },
              tooltip: FlutterSliderTooltip(disabled: true),
            ),
            SizedBox(height: 20),
            TextField(
              controller: minSalaryController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Min Salary ',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: maxSalaryController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Max Salary',
              ),
            ),
            // Button to navigate to the next page
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String minSalaryValue = minSalaryController.text;
                String maxSalaryValue = maxSalaryController.text;

                // Navigate to the details page and pass the data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      docId: widget.docId,
                      industry: widget.industry,
                      category: widget.category,
                      jobposition: widget.jobposition,
                      jobtype: widget.jobtype,
                      workspace: widget.workspace,
                      selectedLocation: widget.selectedLocation,
                      minSalary: minSalaryValue,
                      maxSalary: maxSalaryValue,

                    ),
                  ),
                );
              },
              child: Text('Next'),
            ),

          ],
        ),
      ),
    );
  }
}
