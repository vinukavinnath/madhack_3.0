import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'jobcarduser.dart';

class JobShowing extends StatefulWidget {
  @override
  _JobShowingState createState() => _JobShowingState();
}

class _JobShowingState extends State<JobShowing> {
  String? searchKeyword;
  String? desiredLocation; // Add desiredLocation variable
  String? sortBy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchBarWithFilter(),
            SizedBox(height: 16.0), // Adjust as needed for spacing
            SizedBox(height: 16.0), // Adjust as needed for spacing
            JobCardUser(
                searchKeyword: searchKeyword,
                desiredLocation:
                    desiredLocation), // Pass desiredLocation to JobCard
            // Add other content here
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarWithFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
}
