import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'description.dart';
import 'jobcard.dart';

class JobPosting extends StatefulWidget {
  @override
  _JobPostingState createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  String? searchKeyword;
  String? desiredLocation; // Add desiredLocation variable
  String? sortBy;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildSearchBarWithFilter(),
                SizedBox(height: 16.0), // Adjust as needed for spacing
                _buildCreateNewJobButton(context),
                SizedBox(height: 16.0), // Adjust as needed for spacing
                Text(
                  'Recently Created',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0), // Adjust as needed for spacing
                JobCard(
                    searchKeyword: searchKeyword,
                    desiredLocation:
                        desiredLocation), // Pass desiredLocation to JobCard
                // Add other content here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBarWithFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Jobs...',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          DropdownButton<String?>(
            icon: Icon(Icons.format_list_bulleted_rounded),
            items: <String?>['A-Z', 'Z-A'].map((String? value) {
              return DropdownMenuItem<String?>(
                value: value,
                child: Text(value ?? ''),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                sortBy = newValue; // Update sortBy value on change
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreateNewJobButton(BuildContext context) {
    return PrimaryButton(
      process: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Description()),
        );
      },
      title: '+ Create a New Job',
    );
  }
}
