import 'package:async_and_await/controller/controller_data.dart';
import 'package:async_and_await/view/pages/user/jobfilter.dart';
import 'package:async_and_await/view/widgets/jobcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePageApplicant extends StatefulWidget {
  const HomePageApplicant({super.key});

  @override
  State<HomePageApplicant> createState() => _HomePageApplicantState();
}

class _HomePageApplicantState extends State<HomePageApplicant> {
  //controller data
  final TextEditingController _jobIndustryController =
      JobControllerData().jobIndustryController;
  final TextEditingController _jobCategoryController =
      JobControllerData().jobCategoryController;
  final TextEditingController _jobLocationController =
      JobControllerData().jobLocationController;
  final TextEditingController _jobMinSalaryController =
      JobControllerData().jobMinSalaryController;
  final TextEditingController _MaxSalaryController =
      JobControllerData().jobMaxSalaryController;
  final TextEditingController _jobTagsController =
      JobControllerData().jobTagsController;

  @override
  Widget build(BuildContext context) {
    //screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashbaord',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //search bar and filter button
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //search bar
                SizedBox(
                  width: screenWidth * 0.75,
                  child: const SearchBar(),
                ),
                SizedBox(width: screenWidth * 0.03),
                //filter button
                IconButton(
                  onPressed: () {
                    //modal bottom sheet
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      showDragHandle: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                          initialChildSize: 0.8,
                          expand: false,
                          builder: (context, scrollController) {
                            return const JobFilter();
                          }),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _jobIndustryController.text = value;
                        });
                        print(value);
                      }
                    });
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 241, 169, 254)),
                    shape: MaterialStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.filter_list_rounded,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Most Popular',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //most popular Job cards
          const MostPopularJobCards(),
          //suggest buttons
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  // CustomButtonSmall(text: 'Interaction Designer'),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // CustomButtonSmall(text: 'Technical Lead'),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // CustomButtonSmall(text: 'Business Lead'),
                ],
              ),
            ),
          ),
          //recommended Job
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Text(
              'Recommended For You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //recommended job cards
          const Expanded(child: RecommendedJobCards()),
        ],
      ),
    );
  }
}

class RecommendedJobCards extends StatelessWidget {
  const RecommendedJobCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Text('No Data');
          } else {
            final jobData = snapshot.data!.docs.asMap();
            return SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: jobData.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 6,
                          right: 6,
                          top: 6,
                        ),
                        child: JobCard(
                          width: MediaQuery.of(context).size.width,
                          jobID: jobData[index]!.id,
                          jobTitile:
                              jobData[index]!.data()['emp_category'] ?? 'null',
                          companyName:
                              jobData[index]!.data()['emp_comp_name'] ?? 'null',
                          jobLocation:
                              jobData[index]!.data()['emp_location'] ?? 'null',
                          jobType:
                              jobData[index]!.data()['emp_jobtype'] ?? 'null',
                          jobWorkspace:
                              jobData[index]!.data()['emp_workspace'] ?? 'null',
                          salary: jobData[index]!.data()['emp_min_Salary'] ??
                              'null',
                          isSaved: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class MostPopularJobCards extends StatelessWidget {
  const MostPopularJobCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return const Text('No Data');
            } else {
              final jobData = snapshot.data!.docs.asMap();
              return Container(
                margin: const EdgeInsets.only(
                  bottom: 6,
                  left: 6,
                  top: 6,
                ),
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: jobData.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          JobCard(
                            width: 260,
                            jobID: jobData[index]!.id,
                            jobTitile: jobData[index]!.data()['emp_category'] ??
                                'null',
                            companyName:
                                jobData[index]!.data()['emp_comp_name'] ??
                                    'null',
                            jobLocation:
                                jobData[index]!.data()['emp_location'] ??
                                    'null',
                            jobType:
                                jobData[index]!.data()['emp_jobtype'] ?? 'null',
                            jobWorkspace:
                                jobData[index]!.data()['emp_workspace'] ??
                                    'null',
                            salary:
                                jobData[index]!.data()['emp_min_Salary'] ?? 0,
                            isSaved: false,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
