import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'jobcarduser.dart';

class JobShowing extends StatefulWidget {
  const JobShowing({super.key});

  @override
  _JobShowingState createState() => _JobShowingState();
}

class _JobShowingState extends State<JobShowing> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/noise.webp',
                ),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildSearchBarWithFilter(),
                const SizedBox(height: 16.0), // Adjust as needed for spacing
                const SizedBox(height: 16.0), // Adjust as needed for spacing
                JobCardUser(
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
}
