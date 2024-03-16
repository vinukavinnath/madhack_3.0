import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JobCard extends StatefulWidget {
  JobCard({
    super.key,
    required this.width,
    required this.jobID,
    required this.jobTitile,
    required this.companyName,
    required this.jobLocation,
    required this.jobType,
    required this.jobWorkspace,
    required this.salary,
    required this.isSaved,
  });

  double width;
  final String jobID;
  final String jobTitile;
  final String companyName;
  final String jobLocation;
  final String jobType;
  final String jobWorkspace;
  final String salary;
  final bool isSaved;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  CollectionReference user = FirebaseFirestore.instance.collection('User');
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isSaved = false;

  void bookMarkJob() async {
    try {
      await user
          .doc(currentUser!.email)
          .collection('Saved Jobs')
          .doc(widget.jobID)
          .set({
        'datetime': DateTime.now(),
      });
      setState(() {
        isSaved = true;
      });
    } on FirebaseException catch (e) {
      print(e);
      _showSnackBar('Error occured, Please try again later');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 180,
      width: widget.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amberAccent,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5.0, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //company logo and save icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //company logo
              const Icon(Icons.home_repair_service_rounded),
              //saved icon
              IconButton(
                onPressed: bookMarkJob,
                icon: isSaved
                    ? const Icon(
                        Icons.bookmark_rounded,
                      )
                    : const Icon(
                        Icons.bookmark_border_rounded,
                      ),
              ),
            ],
          ),
          //Job title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.jobTitile,
                style: TextStyle(
                  fontSize: (widget.width > 300) ? 24 : 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              //comapny name and location
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    //comapny name
                    Text('${widget.companyName} - '),
                    //location
                    Text(widget.jobLocation),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //Job type
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 247, 156, 150),
                      ),
                      child: Text(
                        widget.jobType,
                        style: TextStyle(
                          fontSize: (widget.width > 300) ? 14 : 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    //job workspace
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 247, 156, 150),
                      ),
                      child: Text(
                        widget.jobWorkspace,
                        style: TextStyle(
                          fontSize: (widget.width > 300) ? 14 : 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //salary
              Row(
                children: [
                  Text(
                    '\$${widget.salary}',
                    style: TextStyle(
                      fontSize: (widget.width > 300) ? 22 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text('/Mo'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
