import 'package:flutter/material.dart';

class JobCard extends StatefulWidget {
  JobCard({
    super.key,
    required this.width,
    required this.jobTitile,
    required this.companyName,
    required this.jobLocation,
    required this.jobType,
    required this.salary,
    required this.isSaved,
  });

  double width;
  final String jobTitile;
  final String companyName;
  final String jobLocation;
  final String jobType;
  final int salary;
  final bool isSaved;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
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
                onPressed: () {},
                icon: const Icon(
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              //comapny name and location
              Row(
                children: [
                  //comapny name
                  Text('${widget.companyName} - '),
                  //location
                  Text(widget.jobLocation),
                ],
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //Job type
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 247, 156, 150),
                ),
                child: Text(
                  widget.jobType,
                ),
              ),
              //salary
              Row(
                children: [
                  Text(
                    '\$${widget.salary}',
                    style: const TextStyle(
                      fontSize: 22,
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
