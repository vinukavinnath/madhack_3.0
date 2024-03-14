import 'package:async_and_await/view/widgets/button_small.dart';
import 'package:async_and_await/view/widgets/jobcard.dart';
import 'package:async_and_await/view/widgets/searchbar.dart';
import 'package:async_and_await/view/pages/user/jobfilter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
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
                  child: const CustomSearchBar(),
                ),
                SizedBox(width: screenWidth * 0.03),
                //filter button
                const CustomFilterButton(),
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
                  CustomButtonSmall(text: 'Interaction Designer'),
                  SizedBox(
                    width: 5,
                  ),
                  CustomButtonSmall(text: 'Technical Lead'),
                  SizedBox(
                    width: 5,
                  ),
                  CustomButtonSmall(text: 'Business Lead'),
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
                      JobCard(
                        width: MediaQuery.of(context).size.width,
                        jobTitile:
                            jobData[index]!.data()['job_position'] ?? 'null',
                        companyName:
                            jobData[index]!.data()['company_name'] ?? 'null',
                        jobLocation:
                            jobData[index]!.data()['job_location'] ?? 'null',
                        jobType: jobData[index]!.data()['job_type'] ?? 'null',
                        salary: jobData[index]!.data()['minimum_salary'] ?? 0,
                        isSaved: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            );
            // return Text(jobData[0]!.data()['employer_email']);
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
              return SizedBox(
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
                          jobTitile:
                              jobData[index]!.data()['job_position'] ?? 'null',
                          companyName:
                              jobData[index]!.data()['company_name'] ?? 'null',
                          jobLocation:
                              jobData[index]!.data()['job_location'] ?? 'null',
                          jobType: jobData[index]!.data()['job_type'] ?? 'null',
                          salary: jobData[index]!.data()['minimum_salary'] ?? 0,
                          isSaved: false,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  },
                ),
              );
              // return Text(jobData[0]!.data()['employer_email']);
            }
          },
        ),
        // child: Row(
        //   children: [
        //     JobCard(
        //       width: 260,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     JobCard(
        //       width: 260,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const JobFilter();
            },
          ),
        );
      },
      style: const ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Color.fromARGB(255, 241, 169, 254)),
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
    );
  }
}
