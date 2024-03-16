import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'description.dart';
import 'jobcard.dart';

class JobPosting extends StatefulWidget {
  const JobPosting({super.key});

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
    return Scaffold(
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSearchBarWithFilter(),
              const SizedBox(height: 16.0), // Adjust as needed for spacing
              _buildCreateNewJobButton(context),
              const SizedBox(height: 16.0), // Adjust as needed for spacing
              const Text(
                'Recently Created',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0), // Adjust as needed for spacing
              JobCard(
                  searchKeyword: searchKeyword,
                  desiredLocation:
                      desiredLocation), // Pass desiredLocation to JobCard
              // Add other content here
            ],
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
              decoration: const InputDecoration(
                hintText: 'Search Jobs...',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          DropdownButton<String?>(
            icon: const Icon(Icons.format_list_bulleted_rounded),
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
